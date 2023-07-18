import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/shimmer.dart';
import '../../../../core/utils/colors.dart';

class CustomizedCachedImage extends StatelessWidget {
  CustomizedCachedImage(
      {required this.imageURL,
      this.width,
      this.height,
      this.borderRadius = 12,
      super.key});
  final double? width;
  final double? height;
  final String imageURL;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageURL,
        //! Add skeleton
        placeholder: (_, String url) => Stack(
              children: [
                ShimmerWidget(height: height, width: width),
              ],
            ),
        //! Add error Icon
        errorWidget: (_, String url, error) => Icon(Icons.error),
        imageBuilder: (_, ImageProvider imageProvider) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: white,
                image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius)))));
  }
}
