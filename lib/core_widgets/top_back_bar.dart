import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qrpay/constants/images.dart';
 
import 'package:qrpay/services/auth_provider_widget.dart';
import 'package:qrpay/services/communications.dart';
import 'package:qrpay/services/image_services.dart';
import 'package:qrpay/services/navigation.dart';
import 'package:qrpay/services/ui_services.dart';
import 'package:qrpay/theming/theme_controller.dart';
import 'image_picker_grid_thingie.dart';
import 'not_logged_in_dialog_box.dart';
import 'proceed_button.dart';

class BackBar extends StatelessWidget {
  final String text;
  final Function onPressed;
  final List<Widget> actions;
  final IconData icon;

  BackBar({
    Key key,
    @required this.icon,
    @required this.onPressed,
    @required this.text,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  icon ?? Icons.arrow_back_ios_rounded,
                ),
                onPressed: onPressed ?? () {
                        NavigationService().pop( context);
                      },
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (actions != null && actions.isNotEmpty)
                Row(
                  children: actions.map((e) {
                    return e;
                  }).toList(),
                ),
              PopupMenuButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: ThemeBuilder.of(context).getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      child: Text("Feedback / Suggestion"),
                    ),
                  ];
                },
                onSelected: (val) {
                  if (val == 1) {
                    UIServices()
                        .showDatSheet(FeedbackBottomSheet(), true, context);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FeedbackBottomSheet extends StatefulWidget {
  final String initialText;
  final String additionalInfo;
  FeedbackBottomSheet({
    Key key,
    this.initialText,
    this.additionalInfo,
  }) : super(key: key);

  @override
  _FeedbackBottomSheetState createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  TextEditingController descriptionEditingController;
  bool processing = false;
  String additionalInfo;
  List<File> images = [];
  List<File> tempImages = [];
  List<String> imgUrls = [];

  @override
  void initState() {
    super.initState();
    additionalInfo = widget.additionalInfo;
    descriptionEditingController = widget.initialText == null
        ? TextEditingController()
        : TextEditingController(
            text: widget.initialText,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Feedback / Suggestion",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: false,
                  background: Image(
                    image: AssetImage(
                      askQuestion,
                    ),
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
              ImagePickerGridThingie(
                images: images,
                imageMode: false,
                crossAxisCount: 3,
                text: "[OPTIONAL] Images",
                pickImages: () async {
                  tempImages = await ImageServices().pickImages(
                    context,
                    limit: 10,
                  );

                  if (images.length < 11) {
                    for (var element in tempImages) {
                      images.add(element);
                    }
                  } else {
                    CommunicationServices().showSnackBar(
                      "You can not attach more than 10 images to this suggestion.",
                      context,
                    );
                  }

                  if (mounted) setState(() {});
                },
              ),
              ImagePickerGridThingie(
                images: images,
                imageMode: true,
                crossAxisCount: 3,
                pickImages: null,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    TextFormField(
                      maxLines: 5,
                      controller: descriptionEditingController,
                      decoration: InputDecoration(
                          labelText: "Please describe your idea in detail"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 30,
                  )
                ]),
              ),
            ],
          ),
        ),
        ProceedButton(
          text: "Submit",
          enablable: false,
          processable: true,
          processing: processing,
          onTap: () {
            if (descriptionEditingController.text.trim().isEmpty &&
                images.isEmpty) {
              CommunicationServices().showToast(
                  "Please type out your suggestion / feedback", Colors.green);
            } else {
              if (AuthProvider.of(context).auth.isSignedIn()) {
                if (mounted) {
                  setState(() {
                    processing = true;
                  });
                }

                uploadImages();
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return NotLoggedInDialogBox();
                    });
              }
            }
          },
        ),
      ],
    );
  }

  uploadImages() async {
    setState(() {
      processing = true;
    });

    imgUrls = await ImageServices().uploadImages(
      path: "feedback_images",
      onError: () {
        setState(() {
          processing = false;
        });

        CommunicationServices().showSnackBar(
          "There was an error in uploading the feedback Images. Please check your internet connection and try again",
          context,
        );
      },
      images: images,
    );

    if (processing) uploadFeedback();
  }

  uploadFeedback() async {
    await FirebaseDatabase.instance
        .reference()
        .child("feedback")
        .child(AuthProvider.of(context).auth.getCurrentUID())
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      "details": descriptionEditingController.text,
      "additionalInfo": additionalInfo,
      "images": imgUrls
    }).then(
      (value) {
        images.clear();
        imgUrls.clear();
        descriptionEditingController.clear();

        CommunicationServices().showToast(
          "Your feedback has been received. We appreciate your feedback and we'll review and work on it in the shortest time possible",
          Colors.blue,
        );

        if (mounted) {
          setState(
            () {
              processing = false;
            },
          );
        }
      },
    );
  }
}
