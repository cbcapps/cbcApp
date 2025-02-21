import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/res/colors.dart';

import '../../../res/pages_name.dart';
import '../../controllers/CardController.dart';

class DialogExipreCardCus extends StatelessWidget {
  DialogExipreCardCus({super.key});

  final CardController controllerCard = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.26,
      width: Get.width * 0.9,
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
              child:
                  //  Text(
                  //   '234'.tr,
                  //   overflow: TextOverflow.ellipsis,
                  //   textAlign: TextAlign.center,
                  //   maxLines: 6,
                  //   style: TextStyle(
                  //     fontSize: Get.width * 0.04,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),

                  Text.rich(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 6,
                TextSpan(
                  style: TextStyle(
                    fontSize: Get.width * 0.043,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                        text: '238'.tr, style: TextStyle(color: Colors.red)),
                    TextSpan(text: ' '),
                    TextSpan(text: '239'.tr),
                  ],
                ),
              )),
          SizedBox(
            height: Get.height * 0.02,
          ),
          methodButton('121'.tr, () {
            Get.back();
            Get.toNamed(
              PagesName.accountScrn,
              arguments: {'ToActiveCard': 'Yes'},
            );
          }, AppColors.cbcColor),
          SizedBox(
            height: Get.height * 0.015,
          ),
          methodButton('108'.tr, () {
            Get.back();

            controllerCard.tabController?.animateTo(1);

            Get.toNamed(
              PagesName.cardScrn,
            );
          }, Colors.green),
        ],
      ),
    );
  }

  methodButton(String txt, void Function()? onPressed, Color colorBtn) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.065),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Get.width * 0.04),
        child: MaterialButton(
          onPressed: onPressed,
          color: colorBtn,
          splashColor: Colors.blue,
          elevation: 0,
          focusElevation: 0,
          height: Get.height * 0.06,
          child: Text(
            txt,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: Get.width * 0.035,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
    // End Method
  }
  // end Class
}
