import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleImage extends StatelessWidget {
  final dynamic image;
  final double height;
  final double width;
  const SingleImage({
    Key key,
    @required this.image,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      height: height,
      width: width,
      image: image is File
          ? FileImage(image)
          : image.toString().contains("assets/images")
              ? AssetImage(image.toString())
              : CachedNetworkImageProvider(
                  image.toString(),
                ),
      fit: BoxFit.cover,
    );
  }
}
