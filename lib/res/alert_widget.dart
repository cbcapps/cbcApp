import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class AlertWidgetCustom extends StatelessWidget {
  const AlertWidgetCustom({super.key, required this.bodyMsg});

  final String bodyMsg;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        SizedBox(
          height: 10,
        ),
        //
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            bodyMsg,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.black,
            ),
          ),
        ),

        // Btn
        // ===============
        InkWell(
          //
          onTap: () {
            //
            Get.back();
            //
          },

          //
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: AppColors.cbcColor,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
