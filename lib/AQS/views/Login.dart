import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ui_ecommerce/AQS/controllers/Login_controller.dart';
import 'package:ui_ecommerce/AQS/views/Register.dart';
import 'package:ui_ecommerce/res/colors.dart';
import '../controllers/FirstController.dart';
class Login extends StatelessWidget {
  Login({super.key});
  final Login_controller controller = Get.put(Login_controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _logo(),
          _space(Get.height * 0.02),
          _text("170" , Get.width * 0.035,AppColors.aqsfullGreen,FontWeight.bold),
          _space(Get.height * 0.035),
          _textme('3' , controller.phone_ , false),
          _space(Get.height * 0.02),
          _textme('4' , controller.password_ , true),
          _space(Get.height * 0.02),
          GetBuilder<Login_controller>(builder: (builder){
            if(builder.loading){
              return loading_();
            }else{
              return _buttonLogin();
            }
          }),
          GetBuilder<Login_controller>(builder: (builder){
            if(builder.errorlogin){
              return isError(builder.errormsg);
            }else{
              return SizedBox();
            }
          }),
          _space(Get.height * 0.02),
          _text("13" , Get.width * 0.035,AppColors.aqsfullGreen,FontWeight.bold),
          _space(Get.height * 0.02),
          createAccount()
        ],
      ),

    );
  }
  createAccount(){
    return Container(
      width: Get.width,
      height: Get.width * 0.2,
      color: AppColors.cbcGreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _text("171" , Get.width * 0.035,Colors.white,FontWeight.w400),
              SizedBox(
                width: Get.width * 0.01,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=> Register());
                },
                child: _text("172" , Get.width * 0.035,AppColors.aqsyallow,FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: Get.width * 0.03,
          ),
          GestureDetector(
            onTap: (){
              FirstController firstController = Get.put(FirstController());
              firstController.onItemTapped(0);
            },
            child: _text("181" , Get.width * 0.03, Colors.white,FontWeight.bold),
          ),
        ],
      ),
    );
  }

  isError(error){
    return Padding(padding: EdgeInsets.only(top: Get.height * 0.01),
    child: Center(
      child: Text('${error}'.tr , style: TextStyle(
        color: Colors.redAccent,
        fontSize: Get.height * 0.015
      ),),
    ),
    );
  }
  loading_(){
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
      color: Colors.black,
      size: 50,
    ),);
  }
  _logo(){
    return Center(
      child: Image.asset("assets/images/AQS.png",
        height: Get.width * 0.7,
      ),
    );
  }
  _text(String title , double size , Color color , FontWeight fontWeight){
    return Center(
      child: Text(title.tr,
        textAlign: TextAlign.center,
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

  Padding _textme(String title , TextEditingController textEditingController , bool ispassword){
    return Padding(padding: EdgeInsets.only(right: Get.width * 0.1 , left: Get.width * 0.1),
      child:   Container(
        child: TextField(
          style: TextStyle(
              color: Colors.white,
              fontSize: Get.width * 0.03
          ),
          obscureText: ispassword,
          controller: textEditingController,
          decoration:   InputDecoration(
            fillColor: AppColors.cbcGreen, filled: true,
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.cbcGreen, width: 1.0),
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.cbcGreen, width: 1.0),
            ),
            hintText: title.tr,
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: Get.width * 0.03
            )
          ),
        ),
      ),
    );
  }

  _buttonLogin(){
    return Center(
      child: Padding(padding: EdgeInsets.only(right: Get.height * 0.04 , left: Get.height * 0.04),
        child: GestureDetector(
          onTap: (){
           controller.Login();
          },
          child: Container(
            width: Get.height * 0.20,
            height: Get.height * 0.035,
            color: AppColors.aqsyallow,
            child: Center(
              child: Text(
                "1".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.aqsfullGreen,
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
