import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:qrpay/theming/theme_controller.dart';

import 'single_thumbnail.dart';

class ImagePickerGridThingie extends StatefulWidget {
  final List images;
  final bool imageMode;
  final String text;
  final int crossAxisCount;
  final bool noSliver;
  final Function pickImages;
  ImagePickerGridThingie({
    Key key,
    @required this.images,
    this.text,
    @required this.imageMode,
    this.noSliver = false,
    this.crossAxisCount = 3,
    @required this.pickImages,
  }) : super(key: key);

  @override
  _ImagePickerGridThingieState createState() => _ImagePickerGridThingieState();
}

class _ImagePickerGridThingieState extends State<ImagePickerGridThingie> {
  @override
  Widget build(BuildContext context) {
    return !widget.imageMode
        ? widget.noSliver != null && widget.noSliver
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: InkWell(
                  onTap: () {
                    widget.pickImages();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 1,
                        color: ThemeBuilder.of(context).getCurrentTheme() ==
                                Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate),
                          Text(widget.text ?? "Add Images")
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      child: InkWell(
                        onTap: () {
                          widget.pickImages();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 1,
                              color:
                                  ThemeBuilder.of(context).getCurrentTheme() ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate),
                                Text(widget.text ?? "Add Images")
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
        : widget.noSliver != null && widget.noSliver
            ? SizedBox(
                height: 100,
                child: widget.images.isEmpty
                    ? Center(
                        child: Text(
                          "No Images Yet",
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: widget.images.map((e) {
                            return SingleThumbnail(
                              asset: e,
                              onCloseThingiePressed: () {
                                if (mounted) {
                                  setState(() {
                                    widget.images.remove(e);
                                  });
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
              )
            : SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    File asset = widget.images[index];
                    return SingleThumbnail(
                      asset: asset,
                      onCloseThingiePressed: () {
                        if (mounted) {
                          setState(() {
                            widget.images.remove(widget.images[index]);
                          });
                        }
                      },
                    );
                  },
                  childCount: widget.images.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                ),
              );
  }

  body() {
    return DottedBorder(
      child: widget.noSliver
          ? GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
              ),
            )
          : SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                File asset = widget.images[index];
                return SingleThumbnail(
                  asset: asset,
                  onCloseThingiePressed: () {
                    if (mounted) {
                      setState(() {
                        widget.images.remove(widget.images[index]);
                      });
                    }
                  },
                );
              }, childCount: widget.images.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
              ),
            ),
    );
  }
}
