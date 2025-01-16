import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/Cart_controller.dart';
import 'package:ui_ecommerce/AQS/controllers/Checkout_controller.dart';
import 'package:ui_ecommerce/AQS/controllers/Delivery_controller.dart';
import 'package:ui_ecommerce/AQS/views/Payment.dart';
import 'package:ui_ecommerce/res/colors.dart';

import 'ConfirmationPage.dart';
import 'Delivery.dart';
class Checkout extends StatelessWidget {
   Checkout({super.key});
   final Checkout_controller controller = Get.find();
   final Cart_controller cart_controller = Get.put(Cart_controller());
   final Delivery_controller delivery_controller = Get.put(Delivery_controller());
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.aqsfullGreen,
        elevation: 0.0,
        leadingWidth: Get.height * 0.09,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: Get.height * 0.03 , top: Get.height * 0.02),
          child: GestureDetector(
            child: Text('53'.tr , style: TextStyle(
              fontSize: Get.height * 0.017,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),),
            onTap: () => Get.back(),
          ),
        ),
        centerTitle: true,
        title: Text('54'.tr , style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white

        ),),
      ),
      body: Container(
        child: Theme(
          data: ThemeData(
              canvasColor: Colors.white ,
              fontFamily: 'Tajawal',

          ),
          child: GetBuilder<Checkout_controller>(builder: (builder){
            return Stepper(
              elevation: 0.1,
              type: StepperType.horizontal,
              currentStep: builder.currentStep,
              onStepContinue: builder.ContinueStap,
              onStepCancel: builder.CancelStap,
              steps: [
                Step(

                  title: Text('44'.tr , ),
                  content: Delivery(), // Define DeliveryForm widget
                  isActive: builder.currentStep >= 0,
                    stepStyle: StepStyle(
                      color: ( builder.currentStep >= 0) ? AppColors.aqsfullGreen : Colors.grey  ,
                    )
                ),
                Step(
                  title: Text('45'.tr),
                  content: Payment(), // Define PaymentForm widget
                  isActive: builder.currentStep >= 1 ,
                    stepStyle: StepStyle(
                      color: ( builder.currentStep >= 1) ? AppColors.aqsfullGreen : Colors.grey  ,
                    )
                ),
                Step(
                  title: Text('46'.tr),
                  content: ConfirmationPage(), // Define ConfirmationPage widget
                  isActive: builder.currentStep >= 2,
                    stepStyle: StepStyle(
                      color: ( builder.currentStep >= 2) ? AppColors.aqsfullGreen : Colors.grey  ,
                    )
                ),
              ],
              controlsBuilder: (BuildContext context, ControlsDetails controls) {
                if(controller.currentStep != 2){
                  return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.01),
                    child:  Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if(controller.currentStep == 1){
                              print(43);
                              await controller.addBill(delivery_controller.name.text, delivery_controller.phone.text, delivery_controller.selectedGovernorate, delivery_controller.address.text, controller.price, controller.delivery, BoxCart);
                              controls.onStepContinue!();
                            }else{
                              if(delivery_controller.name.text.isNotEmpty && delivery_controller.address.text.isNotEmpty && delivery_controller.phone.text.isNotEmpty && delivery_controller.selectedGovernorate != null )
                                controls.onStepContinue!();
                              else{
                                Get.snackbar('67'.tr, '66'.tr , colorText: AppColors.aqsfullGreen, backgroundColor: Colors.white);
                              }
                            }
                          },
                          child:  Container(
                            height: Get.height * 0.04,
                            width: Get.height * 0.1,
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: AppColors.aqsfullGreen,
                                border: Border.all(color: AppColors.aqsfullGreen , width: 0.1)
                            ),
                            child: Center(
                              child: Text((controller.currentStep > 0)? '65'.tr : '51'.tr, style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Get.height * 0.015,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.height * 0.015,
                        ),
                        (controller.currentStep == 1)? GestureDetector(
                          onTap: controls.onStepCancel,
                          child:  Container(
                            height: Get.height * 0.04,
                            width: Get.height * 0.1,
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.white12,
                                border: Border.all(color: Colors.grey , width: 0.1)
                            ),
                            child: Center(
                              child: Text('52'.tr, style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Get.height * 0.015,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                        ) : SizedBox()
                      ],
                    ),
                  );
                }else{
                  return SizedBox();
                }

              },
            );
          },
          ),
        ),
      ),
    );
  }
}


