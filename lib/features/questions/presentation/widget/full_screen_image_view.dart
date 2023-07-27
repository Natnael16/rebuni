import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../core/shared_widgets/custom_loading_widget.dart';

class FullScreenImageViewer extends StatelessWidget {
  final String imagePath;

  FullScreenImageViewer({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        loadingBuilder: (context,event){
          return UniqueProgressIndicator();
        },
        imageProvider: NetworkImage(imagePath),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
}
