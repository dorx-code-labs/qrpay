import 'package:qrpay/constants/basic.dart';
import 'package:qrpay/core_widgets/text_loader.dart';
import 'package:qrpay/services/navigation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailedImage extends StatefulWidget {
  final List images;
  DetailedImage({
    Key key,
    @required this.images,
  }) : super(key: key);

  @override
  _DetailedImageState createState() => _DetailedImageState();
}

class _DetailedImageState extends State<DetailedImage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: SizedBox(
                child: CachedNetworkImage(
                  imageUrl: widget.images[count],
                  fit: BoxFit.cover,
                  placeholder: (context, string) {
                    return TextLoader(
                      text: appName,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        icon: Icon(Icons.file_download),
                        onPressed: () {
                          downloadImage(widget.images[count]);
                        }),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.images.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              count = index;
                            });
                          }
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: count == index ? 2 : 0,
                                  color: Colors.white)),
                          child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: CachedNetworkImage(
                                imageUrl: widget.images[index],
                                fit: BoxFit.cover,
                                placeholder: (context, string) {
                                  return TextLoader(
                                    text: appName,
                                    height: 100,
                                    width: 50,
                                  );
                                },
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  downloadImage(String image) async {
    try {
      /*   showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
            bodyText: null,
            buttonText: null,
            onButtonTap: null,
            showOtherButton: null,
            child: Column(
              children: [
                Text(
                  "Downloading the Image",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                LoadingWidget(),
              ],
            ),
          );
        },
      );

      Uri uri = Uri.parse(image);
      var response = await http.get(uri);
      filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);

      NavigationService().pop(context);

      Fluttertoast.showToast(
        msg: "Image saved to Pictures folder",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      ); */
    } catch (e) {
      NavigationService().pop(context);

      Fluttertoast.showToast(
        msg: "There was an error downloading the image : $e",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
    }
  }
}
