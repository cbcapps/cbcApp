import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'joint_widgets/cached_network_image_cus.dart';

class CarsoulSliderCustom extends StatelessWidget {
  const CarsoulSliderCustom({
    super.key,
    required this.images,
    this.heightCus,
  });

  final List<String> images;
  final double? heightCus;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        height: heightCus ?? Get.height * 0.18,

        // onPageChanged: (index, reason) {
        //   controller.changeindex(index);
        // },
      ),
      items: images
          .map(
            (item) => Container(
              // width: double.infinity,
              decoration: BoxDecoration(
                  // color: Colors.amber,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white60)),
              margin: EdgeInsets.all(Get.height * 0.002),
              padding: EdgeInsetsDirectional.only(
                  start: Get.height * 0.004,
                  end: Get.height * 0.004,
                  top: Get.height * 0.004,
                  bottom: Get.height * 0.004),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                // child: Image.asset(
                //   item,
                //   fit: BoxFit.fill,
                // ),
                child: CachedNetworkImageCustom(image: item),
              ),
            ),
          )
          .toList(),
    );
  }
}
