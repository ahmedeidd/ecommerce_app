import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Container getCacheImage(String imageUrl, double size) {
  return Container(
    height: size,
    width: size,
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: Container(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
          ),
        ),
      ),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red),
    ),
  );
}
