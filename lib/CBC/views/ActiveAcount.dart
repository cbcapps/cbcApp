import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/AccountController.dart';
import 'package:ui_ecommerce/res/colors.dart';
class ActiveAcount extends StatelessWidget {
  ActiveAcount({super.key});
  final AccountController controller = Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: GetBuilder<AccountController>(builder: (builder){
       return notActive();
      },),
    );
  }
  Widget Active(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.width * 0.05,),
        Center(
            child:  Text('125'.tr,
              style: TextStyle(
                  color: AppColors.cbcColor,
                  fontSize: Get.width * 0.033,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
        SizedBox(height: Get.width * 0.05,),
        Padding(
          padding: EdgeInsetsDirectional.only(start: Get.width * 0.05 , end: Get.width * 0.05 ),
          child:  Text('126'.tr,
            style: TextStyle(
                color: AppColors.cbcColor,
                fontSize: Get.width * 0.03,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: Get.width * 0.05,),
        Padding(
          padding: EdgeInsetsDirectional.only(start: Get.width * 0.05 , end: Get.width * 0.05 ),
          child:  Text('127'.tr,
            style: TextStyle(
                color: Colors.blue,
                fontSize: Get.width * 0.035,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: Get.width * 0.01,),
        Padding(padding: EdgeInsetsDirectional.only(
            start: Get.width * 0.05 , end: Get.width * 0.05
        ),
          child: TextField(
            controller: controller.number,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(
                fontSize: Get.height * 0.015,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: AppColors.cbcColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                borderSide: BorderSide(color: AppColors.cbcColor,),
              ),
            ),
          ),
        ),
        SizedBox(height: Get.width * 0.05,),
        Center(
          child:  GestureDetector(
            onTap: (){
              if(controller.number.text.isNotEmpty){
                controller.fetchRefresh();
              }
            },
            child: Container(
              height: Get.width * 0.1,
              width: Get.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.cbcColor,
              ),
              child: Center(
                child: Text('128'.tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.04

                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget notActive(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.width * 0.05,),
        Center(
            child:  Text('125'.tr,
              style: TextStyle(
                  color: AppColors.cbcColor,
                  fontSize: Get.width * 0.033,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
        SizedBox(height: Get.width * 0.05,),
        Padding(
          padding: EdgeInsetsDirectional.only(start: Get.width * 0.05 , end: Get.width * 0.05 ),
            child:  Text('126'.tr,
              style: TextStyle(
                  color: AppColors.cbcColor,
                  fontSize: Get.width * 0.03,
                  fontWeight: FontWeight.bold
              ),
            ),
        ),
        SizedBox(height: Get.width * 0.05,),
        Padding(
          padding: EdgeInsetsDirectional.only(start: Get.width * 0.05 , end: Get.width * 0.05 ),
          child:  Text('127'.tr,
            style: TextStyle(
                color: Colors.blue,
                fontSize: Get.width * 0.035,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: Get.width * 0.01,),
        Padding(padding: EdgeInsetsDirectional.only(
            start: Get.width * 0.05 , end: Get.width * 0.05
        ),
        child: TextField(
          controller: controller.number,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
              fontSize: Get.height * 0.015,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: AppColors.cbcColor,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , bottomLeft: Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.cbcColor,),
            ),
          ),
        ),
        ),

        SizedBox(height: Get.width * 0.05,),
        Padding(
          padding: EdgeInsetsDirectional.only(start: Get.width * 0.05 , end: Get.width * 0.05 ),
          child:  Text('3'.tr,
            style: TextStyle(
                color: Colors.blue,
                fontSize: Get.width * 0.035,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(padding: EdgeInsetsDirectional.only(
            start: Get.width * 0.05 , end: Get.width * 0.05
        ),
          child: TextField(
            controller: controller.phone,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(
                fontSize: Get.height * 0.015,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: AppColors.cbcColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                borderSide: BorderSide(color: AppColors.cbcColor,),
              ),
            ),
          ),
        ),
        SizedBox(height: Get.width * 0.05,),
        Center(
          child:  GetBuilder<AccountController>(builder: (builder){
            if(builder.isActive.value){
              return GestureDetector(
                onTap: () {
                  if(controller.number.text.isNotEmpty){
                    controller.fetchRefresh();
                  }
                },
                child: Container(
                  height: Get.width * 0.1,
                  width: Get.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.cbcColor,
                  ),
                  child: Center(
                    child: Text('128'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.04
                      ),
                    ),
                  ),
                ),
              );
            }else{
               return GestureDetector(
                 onTap: () {
                   if(controller.number.text.isNotEmpty){
                     controller.fetchAccount();
                   }
                 },
                 child: Container(
                   height: Get.width * 0.1,
                   width: Get.width * 0.6,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     color: AppColors.cbcColor,
                   ),
                   child: Center(
                     child: Text('121'.tr,
                       style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontSize: Get.width * 0.04
                       ),
                     ),
                   ),
                 ),
               );
            }
          },),
        ),
        SizedBox(height: Get.width * 0.03,),
        Center(
          child:  GetBuilder<AccountController>(builder: (builder){
              if(builder.isError.value){
                return isError('129'.tr);
              }else if(builder.isFound.value){
                return isAdded('130'.tr);
              }else{
                return SizedBox();
              }
          }),
        ),
      ],
    );
  }
  isAdded(msg){
    return Padding(padding: EdgeInsets.only(top: Get.height * 0.01),
      child: Center(
        child: Text(msg, style: TextStyle(
            color: Colors.green,
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
  isError(msg){
    return Padding(padding: EdgeInsets.only(top: Get.height * 0.01),
      child: Center(
        child: Text(msg, style: TextStyle(
            color: Colors.redAccent,
            fontSize: Get.height * 0.018,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
