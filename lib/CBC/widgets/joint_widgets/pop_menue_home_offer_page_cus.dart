import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/res/images_path.dart';

import '../../../res/colors.dart';
import '../../../res/pages_name.dart';

class PopMenueHomeOfferPageCustom extends StatelessWidget {
  const PopMenueHomeOfferPageCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      borderRadius: BorderRadius.circular(10),
      padding: EdgeInsets.zero,
      // Adjust the width of the popup menu
      constraints: BoxConstraints(
        minWidth: Get.width * 0.3, // Set the minimum width
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      color: AppColors.bakgroundDrop,
      icon: Icon(
        Icons.menu,
        size: 30,
        color: Colors.white,
      ), // The "three dots" icon
      onSelected: (value) {},
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            Get.toNamed(PagesName.mapStoreScren);
          },
          child: childItemWidget('217'.tr, AppImages.laocationPng),
        ),
        PopupMenuItem(
          onTap: () {
            Get.toNamed(PagesName.calculatorScrn);
          },
          child: childItemWidget('206'.tr, AppImages.calculatorPng),
        ),
        PopupMenuItem(
            onTap: () {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                systemNavigationBarColor: null, // Device default
                systemNavigationBarIconBrightness: null, // Device default
                statusBarColor: null, // Device default
                statusBarIconBrightness: null, // Device default
              ));
              Get.toNamed(PagesName.accountScrn);
            },
            child: childItemWidget('120'.tr, AppImages.userIconPng)),
        PopupMenuItem(
          onTap: () {
            Get.toNamed(PagesName.cardScrn);
          },
          child: childItemWidget('150'.tr, AppImages.cardIconPng),
        ),
        PopupMenuItem(
          onTap: () {
            Get.toNamed(PagesName.categroiesScrn);
          },
          child: childItemWidget('10'.tr, AppImages.categoriesIconPng),
        ),
        PopupMenuItem(
          onTap: () {
            Get.toNamed(PagesName.helpScrn);
          },
          child: childItemWidget('149'.tr, AppImages.helpIconPng),
        ),
      ],
    );
  }

  childItemWidget(String txtPage, String image) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: SizedBox(
                  // height: 20,
                  // width: 20,
                  height: Get.height * 0.03,
                  width: Get.width * 0.05,
                  // child: SvgPicture.asset(item.icon),
                  child: Image.asset(
                    image,
                    // fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                // item.txtPage,
                txtPage,
                style: TextStyle(
                    fontSize: Get.width * 0.04,
                    color: AppColors.cbcColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 3),
          Divider(
            color: AppColors.dividerDrop,
            // color: Colors.red,
            height: 0,
          )
        ],
      ),
    );
  }
  // end Class
}
