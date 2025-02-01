import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetLoactionStore extends StatelessWidget {
  const WidgetLoactionStore(
      {super.key, required this.txtStore, required this.imageUrl});

  final String txtStore;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      // width: Get.width * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              // width: Get.width * 0.1,
              // fit: FlexFit.loose,
              child: Stack(
            children: [
              Text(
                // 'ازياء سعد القبنجي',
                txtStore,
                maxLines: 3,
                textAlign: TextAlign.end,
                style: TextStyle(
                  height: 1,
                  fontSize: Get.width * 0.025,
                  // color: Colors.black,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3 // Border thickness
                    ..color = Colors.blue, // Border color
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                // 'ازياء سعد القبنجي',
                txtStore,
                maxLines: 3,
                textAlign: TextAlign.end,
                style: TextStyle(
                  height: 1,
                  fontSize: Get.width * 0.025,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
          // SizedBox(width: Get.width * 0.01),
          Container(
            // color: Colors.amber,
            width: Get.width * 0.11,
            height: Get.width * 0.075,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Get.width * 0.04),
              child: CachedNetworkImage(
                  imageUrl:
                      // 'https://89.116.110.51:3000/uploads/1737442213697.jpg'
                      imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
