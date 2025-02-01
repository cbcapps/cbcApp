import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../res/height_width_cus.dart';
import '../../../res/images_path.dart';
import '../../models/OffersModel.dart';
import '../../views/StorePage.dart';
import '../joint_widgets/cached_network_image_cus.dart';

class ItemOferGridViewCustom extends StatelessWidget {
  const ItemOferGridViewCustom({
    super.key,
    required this.offerItem,
    this.onTapLink,
  });

  final OffersModel offerItem;
  final void Function()? onTapLink;

  @override
  Widget build(BuildContext context) {
    final hieghtCus = Get.height;
    final widthCus = Get.width;
    return Container(
      margin: EdgeInsets.only(
        // top: 6,
        top: hieghtCus * 0.006,
        // left: 6,
        left: widthCus * 0.015,
        // right: 6,
        right: widthCus * 0.015,
        // bottom: 6,
        bottom: hieghtCus * 0.006,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Get.width * 0.03),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurStyle: BlurStyle.normal,
            blurRadius: 1,
            offset: const Offset(0, 0),
            spreadRadius: 1,
          )
        ],
      ),
      child: InkWell(
        onTap: onTapLink,
        // () {
        //   // Get.to(() => StorePage(), arguments: [
        //   //   {"id": dicountItem.storeId}
        //   // ]);
        // },
        child: Column(
          children: [
            SizedBox(
              // height: Getheight * 0.12,
              height: heightNavBarCustom(context) * 0.14,
              width: double.infinity,
              // color: Colors.amber,
              // child: Image.asset(
              //   AppImages.appIcon,
              //   // fit: BoxFit.cover,
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Get.width * 0.03)),
                child: CachedNetworkImageCustom(
                  image: offerItem.logo,
                ),
              ),
            ),
            buildDivider(),
            Container(
              margin: EdgeInsets.symmetric(
                // vertical: 8,
                vertical: Get.height * 0.0095,
                horizontal: Get.width * 0.015,
              ),
              child: Text(
                // 'ازياء ياسر الدماس',
                // 'الدماس الدماس الدماس الدماس الدماس الدماس',
                offerItem.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  // fontSize: 12,
                  fontSize: Get.width * 0.034,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            buildDivider(),
            Container(
              // color: Colors.amber,
              padding: EdgeInsets.only(
                // top: 5,
                top: Get.height * 0.01,
                left: Get.width * 0.01,
                right: Get.width * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        // top: 5,
                        bottom: Get.height * 0.01),
                    child: SizedBox(
                      // height: 20,
                      // width: 20,
                      height: Get.height * 0.025,
                      width: Get.width * 0.05,
                      child: SvgPicture.asset(AppImages.fire),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      // '50%',
                      // '10000000000000000000000 ',
                      offerItem.discount,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        // fontSize: 16,
                        fontSize: Get.width * 0.042,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // SizedBox(width: 25),
                  // // Spacer(),
                  // SizedBox(
                  //   height: 35,
                  //   width: 24,
                  //   child: SvgPicture.asset(AppImages.favoriteMark),
                  // ),
                  // SizedBox(width: 15),
                  // Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildDivider() {
    return Divider(color: AppColors.black.withOpacity(0.05), height: 0);
  }
}
