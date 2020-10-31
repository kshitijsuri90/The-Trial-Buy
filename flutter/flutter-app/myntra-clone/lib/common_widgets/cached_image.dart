import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final BoxShape shape;

  CachedImage({this.url, this.height, this.width = double.infinity, this.shape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: imageProvider,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
        ),
        child: Image.asset(
          'assets/images/blank_image.png',
          fit: BoxFit.cover,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
        ),
        child: Image.asset(
          'assets/images/blank_image.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
