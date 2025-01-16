import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/Checkout_controller.dart';
class ConfirmationPage extends StatelessWidget {
  ConfirmationPage({super.key});
  final Checkout_controller checkout_controller = Get.put(Checkout_controller());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        height: Get.height * 0.5,
        child: GetBuilder<Checkout_controller>(builder: (builder){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height : Get.height * 0.05),
              (builder.isPay.value)? Icon(Icons.check_circle, color: Colors.green, size: Get.height * 0.05)
              : Icon(Icons.error_outlined, color: Colors.red, size: Get.height * 0.05),
              SizedBox(height : Get.height * 0.012),
              Text((builder.isPay.value)?'55'.tr : '68'.tr ,
                  style: TextStyle(
                      fontSize: Get.height * 0.02
                  )),
              SizedBox(height : Get.height * 0.05),
              GestureDetector(
                onTap: (){

                  Get.back();
                },
                child:  Container(
                  height: Get.height * 0.045,
                  width: Get.height * 0.2,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.deepPurple,
                      border: Border.all(color: Colors.deepPurple , width: 0.1)
                  ),
                  child: Center(
                    child: Text('52'.tr, style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.height * 0.015,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ),

            ],
          );
        },),
      ),
    );
  }
}
