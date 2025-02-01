import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/res/colors.dart';

import '../../../res/images_path.dart';

class ArrangeSuctionCustom extends StatelessWidget {
  const ArrangeSuctionCustom(
      {super.key, required this.arrangeBy, this.onTapDesc, this.onTapAsc});

  final String arrangeBy;
  final void Function()? onTapDesc;
  final void Function()? onTapAsc;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade300)),
          child: Text(
            // 'الترتيب حسب',
            '193'.tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        widgetUpDown(
            '194'.tr,
            arrangeBy == 'desc' ? AppImages.upToDown : AppImages.upToDownBlack,
            arrangeBy == 'desc' ? true : false,
            onTapDesc),
        widgetUpDown(
            '195'.tr,
            arrangeBy != 'desc' ? AppImages.downToUp : AppImages.downToUpBlack,
            arrangeBy != 'desc' ? true : false,
            onTapAsc),
      ],
    );
  }

  widgetUpDown(
    String txt,
    String icon,
    bool isSelcted,
    void Function()? onTapCus,
  ) {
    return GestureDetector(
      onTap: onTapCus,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: isSelcted ? AppColors.cbcColor : null,
          border: Border.all(
            color: isSelcted ? AppColors.cbcColor : Colors.black,
            // width: Get.width * 0.004,
            // strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: Colors.grey.shade300)
        ),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              // color: Colors.amber,
              child: SvgPicture.asset(icon),
            ),
            SizedBox(width: 2),
            Text(
              // 'من الاعلى الى الادنى',
              txt,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 11,
                color: isSelcted ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
