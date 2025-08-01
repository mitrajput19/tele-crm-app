import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool? showLoader;
  final double? borderRadius;

  const CachedImage(
    this.imageUrl, {
    this.width,
    this.height,
    this.fit,
    this.showLoader = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? 'https://i.ibb.co/YPRyPBJ/app-logo.png',
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppColors.gray.withOpacity(.25),
          highlightColor: AppColors.gray.withOpacity(.1),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
