import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/Checkout_controller.dart';
import 'package:ui_ecommerce/main.dart';

import '../../res/colors.dart';
class Payment extends StatelessWidget {
  Payment({super.key});
  final Checkout_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          message(),
          paymentlist(),
          line(),
          spaceH(Get.width * 0.04),
          messageMonthly(),
          monthlylist(),
          GetBuilder<Checkout_controller>(builder: (builder){
            return order(builder.price, builder.delivery, builder.total);

          })
        ],
      ),
    );
  }
   line() {
     return const Divider(
       color: Colors.black12,
     );
   }
   order(price , delivery ,total){
     return Padding(
       padding: EdgeInsetsDirectional.only(start: Get.height * 0.01 , end: Get.height * 0.01 , top: Get.height * 0.02 , bottom: Get.height * 0.02),
       child: Container(
         width: Get.width,
         height: Get.height * 0.22,
         padding:  EdgeInsets.all(Get.height * 0.015),
         decoration: BoxDecoration(
             borderRadius: BorderRadius.all(
                 Radius.circular(Get.height * 0.015) //                 <--- border radius here
             ),
             border: Border.all(color: Colors.grey , width: 0.5)
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('${'50'.tr}' , style: TextStyle(
               fontWeight: FontWeight.w700,
               fontSize: Get.height * 0.018
             ),),
             spaceH(Get.height * 0.02),
             Row(

               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('${'159'.tr} : ' , style: TextStyle(
                   fontSize: Get.height * 0.015,
                   fontWeight: FontWeight.w500,
                 ),),
                 Text('${formatter.format(((controller.price + (controller.price * 30 / 100)) / controller.selectedMonthly.value).round())} ${'160'.tr}', style: TextStyle(
                   fontSize: Get.height * 0.015,
                   fontWeight: FontWeight.w500,
                 ),),
               ],
             ),
             spaceH(Get.height * 0.015),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('${'47'.tr} : ' , style: TextStyle(
                     fontSize: Get.height * 0.015,
                     fontWeight: FontWeight.w500,
                 ),),
                 Text('${formatter.format(((controller.price + (controller.price * 30 / 100))).round())} ${'160'.tr}', style: TextStyle(
                   fontSize: Get.height * 0.015,
                   fontWeight: FontWeight.w500,
                 ),),
               ],
             ),
             spaceH(Get.height * 0.015),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('${'48'.tr} : ' , style: TextStyle(
                   fontSize: Get.height * 0.015,
                   fontWeight: FontWeight.w500,
                 ),),
                 Text('${formatter.format(delivery)} ${'160'.tr}' ,
                   style: TextStyle(
                     fontWeight: FontWeight.w500,
                   fontSize: Get.height * 0.015,
                 ),),
               ],
             ),
             spaceH(Get.height * 0.015),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('${'49'.tr} : ' , style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: Get.height * 0.015,
                     color: AppColors.aqsfullGreen

                 ),),
                 Text('${formatter.format(((controller.price + (controller.price * 30 / 100) + delivery)).round()) } ${'160'.tr}', style: TextStyle(
                   fontSize: Get.height * 0.015,
                   fontWeight: FontWeight.bold,
                     color: AppColors.aqsfullGreen
                 ),),
               ],
             ),
           ],
         ),
       ),
     );
   }
  monthlylist(){
    return Padding(
      padding: EdgeInsetsDirectional.only(start: Get.height * 0.00001),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Obx(() => ListTile(
            title: GestureDetector(
              onTap: (){
                controller.updateMonthly(12);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('12 ${'164'.tr}'),
                  spaceW(Get.height * 0.01),
                  Container(
                    height: Get.height * 0.025,
                    width: Get.height * 0.2,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: AppColors.aqsyallow,
                        border: Border.all(color: Colors.deepPurple , width: 0.1)
                    ),
                    child: Center(
                      child: Text('${formatter.format(((controller.price + (controller.price * 30 / 100)) / 12).round())} ${'160'.tr} ${'169'.tr}', style: TextStyle(
                          color: AppColors.aqsfullGreen,
                          fontSize: Get.height * 0.012,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            leading: Radio<int>(
              value: 12,
              activeColor: AppColors.aqsfullGreen,
              groupValue: controller.selectedMonthly.value,
              onChanged: (value) {
                controller.updateMonthly(value!);
              },
            ),
          )),
          Obx(() => ListTile(
            title: GestureDetector(
              onTap: (){
                controller.updateMonthly(6);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('6 ${'164'.tr}'),
                  spaceW(Get.height * 0.01),
                  Container(
                    height: Get.height * 0.025,
                    width: Get.height * 0.2,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: AppColors.aqsyallow,
                        border: Border.all(color: Colors.deepPurple , width: 0.1)
                    ),
                    child: Center(
                      child: Text('${formatter.format(((controller.price + (controller.price * 30 / 100)) / 6).round())} ${'160'.tr} ${'169'.tr}', style: TextStyle(
                          color: AppColors.aqsfullGreen,
                          fontSize: Get.height * 0.012,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            leading: Radio<int>(
              value: 6,
              activeColor: AppColors.aqsfullGreen,
              groupValue: controller.selectedMonthly.value,
              onChanged: (value) {
                controller.updateMonthly(value!);
              },
            ),
          )),

        ],
      ),
    );
  }
  paymentlist(){
    return Padding(
      padding: EdgeInsetsDirectional.only(start: Get.height * 0.00001),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title:  Row(
            children: [
              Text('38'.tr),
              spaceW(Get.height * 0.01),
              FaIcon(FontAwesomeIcons.moneyBill , color: Colors.black,)
            ],
          ),
          leading: Radio<int>(
            value: 1,
            activeColor: AppColors.aqsfullGreen,
            groupValue: 1,
            onChanged: (value) {

            },
          ),
        ),
        paymenytile('39'.tr , FontAwesomeIcons.creditCard),
      ],
    ),
    );
  }
  paymenytile(title , icone){
    return GestureDetector(
      onTap: (){
        Get.snackbar('42'.tr, '43'.tr);
      },
      child: ListTile(
        title:  Row(
          children: [
            Text(title),
            spaceW(Get.height * 0.01),
            FaIcon(icone,color: Colors.black,)
          ],
        ),
        leading: Radio<int>(
          value: 2,
          activeColor: AppColors.aqsfullGreen,
          groupValue: 1,
          onChanged: (value) {

          },
        ),
      ),
    );
  }
   message(){
     return Padding(
       padding: EdgeInsetsDirectional.only(start: Get.height * 0.01 , end: Get.height * 0.01 , bottom: Get.height * 0.01,),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [

           Text('36'.tr,
             textAlign: TextAlign.start,
             style: TextStyle(
                 fontSize: Get.height * 0.02,
                 fontWeight: FontWeight.w700
             ),

           ),
           spaceH(Get.height * 0.01),
           Text('37'.tr,
             textAlign: TextAlign.start,
             style: TextStyle(
                 fontSize: Get.height * 0.016,
                 fontWeight: FontWeight.w500
             ),

           ),
           spaceH(Get.height * 0.01),
           line(),
         ],
       ),
     );
   }
  messageMonthly(){
    return Padding(
      padding: EdgeInsetsDirectional.only(start: Get.height * 0.01 , end: Get.height * 0.01 , bottom: Get.height * 0.01,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('168'.tr,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: Get.height * 0.02,
                fontWeight: FontWeight.w700
            ),
          ),
          spaceH(Get.height * 0.01),
          Text('167'.tr,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: Get.height * 0.016,
                fontWeight: FontWeight.w500
            ),

          ),
          spaceH(Get.height * 0.01),
          line(),
        ],
      ),
    );
  }
   title(){
     return Text('31'.tr,
       style: TextStyle(
           fontSize: Get.height * 0.02,
           fontWeight: FontWeight.bold
       ),

     );
   }
   Padding actions() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01 , end: Get.height * 0.02),
       child: Row(
         children: [
           const Icon(Icons.more_vert),
           spaceW(Get.height * 0.01),
         ],
       ),
     );
   }
   SizedBox spaceH(double size) {
     return SizedBox(
       height: size,
     );

   }
   SizedBox spaceW(double size) {
     return SizedBox(
       width: size,
     );
   }
}
