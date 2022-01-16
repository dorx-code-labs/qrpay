import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qrpay/core_views.dart/detailed_image_view.dart';
import 'package:qrpay/services/navigation.dart';

import 'text_loader.dart';

class OnlineImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final String placeholderText;
  final double width;
  OnlineImage({
    Key key,
    @required this.imageUrl,
    @required this.height,
    @required this.width,
    @required this.placeholderText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService().push(
          context,
          DetailedImage(
            images: [imageUrl],
          ),
        );
      },
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, gh) {
          return TextLoader(
            text: placeholderText,
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.height * 0.6,
          );
        },
      ),
    );
  }
}
