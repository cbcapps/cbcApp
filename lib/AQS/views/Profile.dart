import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/res/colors.dart';
import '../controllers/ProfileController.dart';
class Profile extends StatelessWidget {
  Profile({super.key});
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.aqsfullGreen,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          '120'.tr,
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _space(Get.height * 0.02),
          _text("178" , Get.width * 0.035,AppColors.aqsfullGreen,FontWeight.bold),
          _space(Get.height * 0.02),
          _textme('56' , false ,  controller.fullName),
          _space(Get.height * 0.02),
          _textme('3' , false ,  controller.phone),
          _space(Get.height * 0.02),
          _textme('57' , false  ,  controller.city),
          _space(Get.height * 0.02),
          _textme('58'  , false  , controller.address),
          _space(Get.height * 0.02),
          _text("179" , Get.width * 0.035,AppColors.aqsfullGreen,FontWeight.bold),
          _space(Get.height * 0.02),
          _textme('180' , false ,  controller.typeCard),
          _space(Get.height * 0.02),
          _textme('127' , false ,  controller.numberCard),
          _space(Get.height * 0.02),
          _buttonLogout(),
          _space(Get.height * 0.02),
          GestureDetector(
            onTap: (){
              showConfirmationPrompt();
              //profileController.logout();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.delete , size: Get.width * 0.04,color: Colors.redAccent,),
                SizedBox(width: Get.width * 0.015,),
                Text(
                  'حذف الحساب',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),

        ],
      ),

    );
  }
  void showConfirmationPrompt() {
    Get.defaultDialog(
      title: "حذف الحساب",
      middleText: "هل انت متآكد من ارسال طلب حذف الحساب",
      actions: [
        TextButton(
          onPressed: () {
            controller.deleteAccount();
          },
          child: Text("ارسال"),
        ),
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: Text("الغاء"),
        ),
      ],
    );
  }

  _text(String title , double size , Color color , FontWeight fontWeight){
    return Padding(
      padding: EdgeInsets.only(right: Get.width * 0.05 , left: Get.width * 0.05),
      child: Text(title.tr,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight,
            color : color
        ),
      ),

    );
  }

  SizedBox _space(double size){
    return SizedBox(
      height: size,
    );
  }


  Padding _textme(String title , bool ispassword , value){
    return Padding(padding: EdgeInsets.only(right: Get.width * 0.1 , left: Get.width * 0.1),
      child:   Container(
        child: TextField(
          controller: TextEditingController(text: value.toString()),
          readOnly: true,
          decoration: InputDecoration(
            labelText: title.tr,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
  _buttonLogout(){
    return Center(
      child: Padding(padding: EdgeInsets.only(right: Get.height * 0.04 , left: Get.height * 0.04),
        child: GestureDetector(
          onTap: (){
            controller.logout();
          },
          child: Container(
            width: Get.height * 0.3,
            height: Get.height * 0.035,
            color: AppColors.cbcRed,
            child: Center(
              child: Text(
                "23".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.015
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
