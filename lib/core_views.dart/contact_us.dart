import 'package:qrpay/core_widgets/custom_divider.dart';
import 'package:qrpay/core_widgets/proceed_button.dart';
import 'package:qrpay/core_widgets/top_back_bar.dart';
import 'package:qrpay/services/text_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:qrpay/constants/basic.dart';
import 'package:qrpay/constants/core.dart';
import 'package:qrpay/services/ui_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qrpay/services/auth_provider_widget.dart';
import 'package:qrpay/services/communications.dart';

class ContactUsView extends StatefulWidget {
  ContactUsView({Key key}) : super(key: key);

  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackBar(
                  icon: null,
                  onPressed: null,
                  text: "Contact Us",
                ),
                Text(
                  "Reach out to us. We're quite friendly and we're eager to hear what you have to say?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomDivider(),
                ListTile(
                  onTap: () {
                    launch("tel:$niranPhoneNumber");
                  },
                  leading: Icon(Icons.phone),
                  title: Text(
                    niranPhoneNumber.toString(),
                  ),
                ),
                CustomDivider(),
                ListTile(
                  leading: Icon(
                    Icons.email,
                  ),
                  title: Text(
                    "Email Us",
                  ),
                  onTap: () async {
                    final Email email = Email(
                      body: 'Hello',
                      subject: 'Hello there.',
                      recipients: [
                        customerCareEmail,
                      ],
                      isHTML: false,
                    );

                    await FlutterEmailSender.send(email);
                  },
                ),
                CustomDivider(),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    UIServices().showDatSheet(
                      FeedbackBottomSheet(),
                      true,
                      context,
                    );
                  },
                  child: Text(
                    "Provide Feedback about the app",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "You could also just write to us instead",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          labelText: "First Name",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: secondNameController,
                      decoration: InputDecoration(
                        labelText: "Second Name",
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 5,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: "Comments / Message / Whatever",
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          ProceedButton(
            onTap: () {
              if (descriptionController.text.trim().isEmpty) {
                CommunicationServices().showSnackBar(
                  "You have not typed any comment / message. Type a comment and try again",
                  context,
                );
              } else {
                FirebaseDatabase.instance
                    .reference()
                    .child("contactUs")
                    .child(DateTime.now().millisecondsSinceEpoch.toString())
                    .set({
                  "poster":
                      AuthProvider.of(context).auth.getCurrentUser() == null
                          ? null
                          : AuthProvider.of(context).auth.getCurrentUID(),
                  "time": DateTime.now().millisecondsSinceEpoch,
                  "comment": descriptionController.text.trim(),
                  "firstName": firstNameController.text.trim().isEmpty
                      ? null
                      : firstNameController.text.trim(),
                  "secondName": secondNameController.text.trim().isEmpty
                      ? null
                      : secondNameController.text.trim(),
                  "email": emailController.text.trim().isEmpty
                      ? null
                      : emailController.text.trim(),
                  "phoneNumber": phoneNumberController.text.trim().isEmpty
                      ? null
                      : phoneNumberController.text.trim(),
                }).then((value) {
                  phoneNumberController.clear();
                  emailController.clear();
                  firstNameController.clear();
                  secondNameController.clear();
                  descriptionController.clear();
                  CommunicationServices().showSnackBar(
                    "Your comment has been sent. Thank you. If you left contact details, you will be contacted with a response by ${appName.capitalizeFirstOfEach} Administrators.",
                    context,
                  );

                  setState(() {});
                });
              }
            },
            text: "Submit Comment",
            enablable: false,
            processable: true,
            processing: processing,
          ),
        ],
      ),
    );
  }
}
