import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/res/pages_name.dart';

import '../../../res/colors.dart';

AppBar appBarShopingOfersPageCustom(
  String imageLeading,
  String txtTitle,
  double heightCus,
  double widthCus,
  Widget menueIcon,
  Widget? firstIconAction,
  bool? showArow,
  bool showFavorite,
) {
  return AppBar(
    backgroundColor: AppColors.cbcColor,

    centerTitle: false,
    // leadingWidth: Get.width * 0.09,
    automaticallyImplyLeading: false,

    title: Row(
      children: [
        showArow != null
            ? InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: Get.width * 0.065,
                  height: Get.height * 0.035,
                  // color: Colors.amber,
                  margin: EdgeInsetsDirectional.only(end: Get.width * 0.01),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded, // Back arrow icon
                    color: Colors.white, // Change the color here
                    size: Get.width * 0.06,
                  ),
                ),
              )
            : Container(),
        Container(
          height: heightCus,
          width: widthCus,
          margin: EdgeInsets.only(bottom: 10, top: Get.height * 0.01),
          // color: Colors.amber,
          child: SvgPicture.asset(
            imageLeading,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          margin: EdgeInsets.only(top: Get.height * 0.01),
          child: Text(
            txtTitle,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Get.width * 0.042),
          ),
        ),
      ],
    ),
    actions: [
      showFavorite
          ? GestureDetector(
              onTap: () {
                Get.toNamed(PagesName.shopingFavoriteScrn);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: Get.height * 0.035,
                ),
              ),
            )
          : SizedBox.shrink(),
      firstIconAction != null
          ? firstIconAction
          : Icon(
              Icons.notifications_none_outlined,
              color: Colors.white,
              size: 30,
            ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: menueIcon,
      ),
    ],
  );
}
