import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Help.dart';

import '../../res/colors.dart';
class InstructionsView extends StatelessWidget {
   InstructionsView({super.key});
   final HelpController controller = Get.put(HelpController());

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: ListView(
        children: [
          Center(
            child: SizedBox(
              height: Get.width * 0.3,
              width: Get.width * 0.8,
              child: Image.asset('assets/images/callcenter.png' , fit: BoxFit.fill,),
            ),
          ),
          Container(
            height: Get.width * 0.0003,
            width: Get.width * 0.9,
            color: Colors.black,
          ),
          SizedBox(
            height: Get.width * 0.05,
          ),
         Center(
           child: Text('137'.tr,
             style: TextStyle(
                 color: AppColors.cbcRed,
                 fontWeight: FontWeight.bold,
                 fontSize: Get.width * 0.039
             ),),
         ),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Center(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: Get.width *0.1 , end: Get.width * 0.1),
              child: Text('138'.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.03
                ),),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: Get.width * 0.05,end: Get.width * 0.05),
            child: ListView.builder(
              shrinkWrap: true,
              physics: PageScrollPhysics(),
              padding: EdgeInsetsDirectional.only(start: Get.width * 0.05,end: Get.width * 0.05),
              itemCount: controller.details.length, // عدد العناصر في القائمة
              itemBuilder: (BuildContext context, int index) {
                return  Padding(padding: EdgeInsetsDirectional.only(top: Get.width * 0.03),
                child: Row(
                  children: [
                    Container(
                      width: Get.height * 0.005,
                      height: Get.height * 0.03,
                      color: AppColors.cbcRed,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Expanded(
                      child: Text(
                        controller.details[index]['title']!, // عرض العنوان
                        style: TextStyle(
                          fontSize: Get.width * 0.028,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                );
              },
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Center(
            child: Text('139'.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: Get.width * 0.04,
              ),
            ) ,
          )
        ],
      ),
    );
  }
}
