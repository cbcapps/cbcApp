import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetDialogDetailsSotreLoactionCustom extends StatelessWidget {
  const WidgetDialogDetailsSotreLoactionCustom({
    super.key,
    this.onTapCus,
    required this.urlImage,
    required this.txtNameStore,
  });

  final void Function()? onTapCus;
  final String urlImage;
  final String txtNameStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      width: Get.width * 0.9,
      // color: Colors.amber,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: SizedBox(
              height: Get.height * 0.17,
              width: Get.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Get.width * 0.045),
                child: CachedNetworkImage(imageUrl: urlImage),
              ),
            ),
          ),
          Padding(
            // height: Get.height * 0.075,
            // color: Colors.pink,
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.015, horizontal: Get.width * 0.05),
            child: Text(
              // 'Al Wsknjkak cklnslknlkjlk',
              txtNameStore,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: Get.width * 0.035, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(height: 0, color: Colors.grey.shade200),
          InkWell(
            onTap: onTapCus,
            child: Padding(
              // height: Get.height * 0.075,
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.015, horizontal: Get.width * 0.05),
              // color: Colors.purple,
              child: Text(
                // 'Al Wsknjkak ckljclsjlknn  lkjns lkjlk',
                '223'.tr,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: Get.width * 0.035, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
