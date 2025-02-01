import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../loading_widget/progress_circular_cus.dart';

class CachedNetworkImageCustom extends StatelessWidget {
  const CachedNetworkImageCustom({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => const ProgressCircularWidgetCustom(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
