import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/AccountController.dart';
import 'package:ui_ecommerce/res/colors.dart';
class MyAccount extends StatelessWidget {
   MyAccount({super.key});
   final AccountController controller = Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: GetBuilder<AccountController>(builder: (builder){
        if(builder.isActive.value){
          return Active();
        }else{
          return notActive();
        }
      },),
    );
  }
   Widget Active(){
     return Column(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         SizedBox(height: Get.width * 0.10,),
         SizedBox(
           child:  Image.asset('assets/images/account_active.png',
             width: Get.width * 0.5,
             height: Get.width * 0.3,

           ),
         ),
         SizedBox(
             child:  Text('123'.tr,
               style: TextStyle(
                   color: AppColors.cbcGreen,
                   fontSize: Get.width * 0.04,
                   fontWeight: FontWeight.bold
               ),
             )
         ),
         SizedBox(height: Get.width * 0.05,),
         Padding(
           padding: EdgeInsets.only(left: Get.width * 0.15, right: Get.width * 0.15),
           child: Column(
             children: [
               SizedBox(
                   child:  Text('مجموع الخصومات',
                     style: TextStyle(
                         color: AppColors.cbcColor,
                         fontSize: Get.width * 0.04,
                         fontWeight: FontWeight.bold
                     ),
                   )
               ),
               SizedBox(height: Get.width * 0.01,),
               Container(
                 width: Get.width * 0.45,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   color: AppColors.cbcColor,
                 ),
                 child: Center(
                   child: Text(controller.discountCard.toString() + ' IQD',
                     style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                         fontSize: Get.width * 0.04
                     ),
                   ),
                 ),
               ),
               SizedBox(height: Get.width * 0.05,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   FaIcon(FontAwesomeIcons.personCircleCheck ,
                     color: AppColors.cbcColor,
                     size: Get.width * 0.07,
                   ),
                   Text(controller.userName.value,
                     style: TextStyle(
                       color: AppColors.cbcColor,
                       fontWeight: FontWeight.bold,
                       fontSize: Get.width * 0.04

                     ),

                   )
                 ],
               ),
               SizedBox(height: Get.width * 0.05,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   FaIcon(FontAwesomeIcons.wallet ,
                     color: AppColors.cbcColor,
                     size: Get.width * 0.07,
                   ),
                   Container(
                     width: Get.width * 0.45,
                     decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                    color: AppColors.cbcColor,
                    ),
                     child: Center(
                       child: Text(controller.walletNumber.value,
                         style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.bold,
                             fontSize: Get.width * 0.04

                         ),
                       ),
                     ),
                   ),

                 ],
               ),
               SizedBox(height: Get.width * 0.05,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   FaIcon(FontAwesomeIcons.calendarCheck ,
                     color: AppColors.cbcColor,
                     size: Get.width * 0.07,
                   ),
                   Container(
                     width: Get.width * 0.45,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5),
                       color: AppColors.cbcColor,
                     ),
                     child: Center(
                       child: Text(controller.dateCard.toString(),
                         style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.bold,
                             fontSize: Get.width * 0.04
                         ),
                       ),
                     ),
                   ),

                 ],
               ),
             ],
           ),
         ),
       ],
     );
   }

  Widget notActive(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: Get.width * 0.10,),
       SizedBox(
         child:  Image.asset('assets/images/account_unactive.png',
           width: Get.width * 0.5,
           height: Get.width * 0.3,

         ),
       ),
        SizedBox(
          child:  Text('122'.tr,
            style: TextStyle(
              color: AppColors.cbcRed,
              fontSize: Get.width * 0.04,
              fontWeight: FontWeight.bold
            ),
          )
        ),
        SizedBox(height: Get.width * 0.05,),
        Container(
          margin: EdgeInsets.only(left: Get.width * 0.05 , right:  Get.width * 0.05),
          height: Get.width * 0.003,
          color: AppColors.cbcColor,
        ),
        SizedBox(height: Get.width * 0.05,),
        Padding(
          padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: Get.width * 0.045,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
                color: Colors.black, // اللون الافتراضي للنص
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '124'.tr,
                  style: const TextStyle(
                    color: AppColors.cbcRed
                  )
                ),
                TextSpan(
                  text: '121'.tr,
                  style: const TextStyle(
                    color: AppColors.cbcColor, // اللون المخصص للكلمة
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.tabController?.index = 1;
                      print('تم الضغط على خانة تفعيل البطاقة');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
