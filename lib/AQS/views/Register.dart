import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ui_ecommerce/AQS/controllers/RegisterController.dart';
import 'package:ui_ecommerce/res/colors.dart';
class Register extends StatelessWidget {
  Register({super.key});
  final RegisterController controller = Get.put(RegisterController());
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
          '173'.tr,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,

      ),
      body: ListView(
        children: [
          _logo(),
          _space(Get.height * 0.02),
          _text("174" , Get.width * 0.035,AppColors.aqsfullGreen,FontWeight.bold),
          _space(Get.height * 0.02),
          _textme('56' , controller.nameController , false),
          _space(Get.height * 0.02),
          _textme('3' , controller.phoneController , false),
          _space(Get.height * 0.02),
          _select(),
          _space(Get.height * 0.02),
          _textme('58' , controller.addressController , false),
          _space(Get.height * 0.02),
          _textme('4' , controller.passwordController , false),
          _space(Get.height * 0.02),
          _textme('175' , controller.passwordConfirmController , true),
          _space(Get.height * 0.02),
          GetBuilder<RegisterController>(builder: (builder){
            if(builder.loading){
              return loading_();
            }else{
              return _buttonRegister();
            }
          }),
          GetBuilder<RegisterController>(builder: (builder){
            if(builder.errorRegister){
              return isError(builder.errormsg);
            }else if(builder.successRegister.value){
              return Padding(padding: EdgeInsets.only(top: Get.height * 0.01),
                child: Column(
                  children: [
                    Center(
                      child: Text('177'.tr , style: TextStyle(
                          color: AppColors.cbcGreen,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.height * 0.015
                      ),),
                    ),
                    GestureDetector(
                      child: Center(
                        child: Text('1'.tr , style: TextStyle(
                            color: AppColors.aqsfullGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.height * 0.015
                        ),),
                      ),
                      onTap: (){
                        Get.back();
                      },
                    )
                  ],
                ),
              );
            }else{
              return SizedBox();
            }
          }),
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
                child: _text("172" , Get.width * 0.035,AppColors.aqsyallow,FontWeight.bold),
              )

            ],
          )

        ],
      ),
    );
  }
  _select(){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.1, end: Get.width * 0.1 ),
        child : GetBuilder<RegisterController>(builder: (builder){
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: AppColors.aqsfullGreen , width: 1)
            ),
            width: Get.width * 0.9,
            height: Get.width * 0.12,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint: Text(
                  '57'.tr,
                  style: TextStyle(
                    fontSize: Get.height * 0.015,
                    color: AppColors.cbcGreen,
                  ),
                ),
                items: builder.gonvernorates
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style:  TextStyle(
                        fontSize: Get.height * 0.014,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ))
                    .toList(),
                value: builder.selectedGovernorate,
                onChanged: (value) {
                  builder.changeSelect(value);
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          );
        }));
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
      child: Padding(
        padding: EdgeInsets.only(left: Get.width * 0.03 , right: Get.width * 0.03),
        child: Image.asset("assets/images/AQSvertical.png",
          height: Get.width * 0.5,
          fit: BoxFit.contain,
        ),
      ),
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

  Padding _textme(String title , TextEditingController textEditingController , bool ispassword){
    return Padding(padding: EdgeInsets.only(right: Get.width * 0.1 , left: Get.width * 0.1),
      child:   Container(
        child: TextField(
          style: TextStyle(
              color: AppColors.aqsfullGreen,
              fontSize: Get.width * 0.03
          ),
          obscureText: ispassword,
          controller: textEditingController,
          decoration:   InputDecoration(
              fillColor: Colors.white, filled: true,
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
                  color:  AppColors.aqsfullGreen,
                  fontSize: Get.width * 0.03
              )
          ),
        ),
      ),
    );
  }

  _buttonRegister(){
    return Center(
      child: Padding(padding: EdgeInsets.only(right: Get.height * 0.04 , left: Get.height * 0.04),
        child: GestureDetector(
          onTap: (){
            controller.register();
          },
          child: Container(
            width: Get.height * 0.3,
            height: Get.height * 0.035,
            color: AppColors.aqsyallow,
            child: Center(
              child: Text(
                "176".tr,
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
