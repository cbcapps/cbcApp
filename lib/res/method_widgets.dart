import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'alert_widget.dart';
import 'colors.dart';

class MethodsWidgetClass {
  //
  static loadingMethod({Color colorLoading = Colors.white}) {
    //

    Get.dialog(
      Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            strokeWidth: 7,
            strokeCap: StrokeCap.butt,
            color: colorLoading,
          ),
        ),
      ),
    );

    // end Loading Method
  }

  static dialogAlertmethod({
    String titleMsg = 'Alert',
    required String bodyMsg,
  }) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: titleMsg,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.only(top: 15),
      titleStyle: TextStyle(
        fontSize: Get.width * 0.05,
        fontWeight: FontWeight.bold,
        color: AppColors.cbcRed,
      ),
      content: AlertWidgetCustom(
        bodyMsg: bodyMsg,
      ),
    );
  }
}
