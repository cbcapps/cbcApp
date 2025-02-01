import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/ShopingController.dart';

import '../../../res/colors.dart';
import '../../../res/pages_name.dart';

class DialogWidgetNoticeUserFavoriteCustom extends StatelessWidget {
  DialogWidgetNoticeUserFavoriteCustom({
    super.key,
  });

  final Shopingcontroller _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // final outLineBorder = OutlineInputBorder(
    //   borderSide: BorderSide(color: Colors.grey),
    //   borderRadius: BorderRadius.circular(Get.width * 0.05),
    // );
    return Container(
      height: Get.height * 0.18,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      width: Get.width,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          buildMethodTxt('214'.tr),
          buildMethodTxt('215'.tr),
          SizedBox(height: Get.height * 0.012),
          // SizedBox(
          //   // color: Colors.amber,
          //   height: Get.height * 0.055,
          //   child: TextField(
          //     controller: _controller.cbcNumbrControler,
          //     keyboardType: TextInputType.number,
          //     inputFormatters: [
          //       FilteringTextInputFormatter
          //           .digitsOnly, // Only allows numbers (0-9)
          //     ],
          //     decoration: InputDecoration(
          //       contentPadding:
          //           EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          //       enabledBorder: outLineBorder,
          //       focusedBorder: outLineBorder.copyWith(
          //           borderSide: BorderSide(color: AppColors.cbcColor)),
          //       disabledBorder: outLineBorder,
          //     ),
          //   ),
          // ),
          // SizedBox(height: Get.height * 0.025),
          Obx(() {
            return _controller.checkAddCBCnumbr.value
                ? SizedBox.shrink()
                : Padding(
                    // color: Colors.amber,
                    padding: EdgeInsets.only(top: Get.height * 0.02),
                    child: Center(
                      child: Text(
                        'يحب ملئ الحقل اولا',
                        style: TextStyle(
                          fontSize: Get.width * 0.033,
                          height: 1,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cbcRed,
                        ),
                      ),
                    ),
                  );
          }),
          SizedBox(height: Get.height * 0.025),
          SizedBox(
            height: Get.height * 0.05,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Get.width * 0.06),
                child: MaterialButton(
                  onPressed: () async {
                    // _controller.saveNumbrCBCMethod();
                    await Get.toNamed(PagesName.accountScrn,
                        arguments: 'FromShopingg');

                    Get.back();
                  },
                  color: AppColors.cbcColor,
                  height: Get.height * 0.06,
                  child: Text(
                    '219'.tr,
                    style: TextStyle(
                      fontSize: Get.width * 0.035,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMethodTxt(String txtNotice) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Get.height * 0.02,
          width: Get.width * 0.02,
          decoration: BoxDecoration(
            color: AppColors.black,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: Get.width * 0.01,
        ),
        Container(
          // color: AppColors.cbcRed,
          width: Get.width * 0.7,
          child: Text(
            txtNotice,
            maxLines: 4,
            style: TextStyle(
              fontSize: Get.width * 0.033,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
    // end Method
  }
  // end Class
}
