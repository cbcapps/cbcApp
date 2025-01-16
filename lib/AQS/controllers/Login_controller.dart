import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/Bindings/Landing_bindings.dart';
import 'package:ui_ecommerce/AQS/Services/RemoteServices.dart';
import 'package:ui_ecommerce/AQS/controllers/FirstController.dart';
import 'package:ui_ecommerce/main.dart';
import 'package:ui_ecommerce/AQS/views/Landing.dart';
class Login_controller extends GetxController{

  late bool isremember = false;
  late bool loading = false;
  late bool errorlogin = false;
  late String errormsg = '';
  late TextEditingController phone_  = TextEditingController();
  late TextEditingController password_ = TextEditingController();
  //void for check Remember me
  void is_checking() {
    if(isremember){
      isremember = false;
    }else{
      isremember = true;
    }
    update();
   }
   void is_loading(){
    loading = true;
    update();
   }
  void isnot_loading(){
    loading = false;
    update();
  }
  void is_error(){
    errorlogin = true;
    update();
  }
   void Login() async{
     is_loading();
    var response = await RemoteServices.login(phone_.text.trim() , password_.text.trim());
    if(response != null){
      var json_response = jsonDecode(response);
      if(json_response['message'] == "Login Successfully"){
        await sharedPreferences.setString('token', json_response['access_token']);
        await sharedPreferences.setInt('phone', int.parse(json_response['phone']));
        await sharedPreferences.setInt('user_id', json_response['user_id']);
        await sharedPreferences.setString('name', json_response['username']);
        await sharedPreferences.setString('city', json_response['city']);
        await sharedPreferences.setString('address', json_response['address']);
        await sharedPreferences.setBool('remember', true);
        isnot_loading();
        FirstController controller = Get.put(FirstController());
        controller.onItemTapped(0);
        update();
      }else if(json_response['message'] == "No user found"){
        errormsg = "24";
        is_error();
        print(json_response['message']);
        isnot_loading();
      }else{
        errormsg = "25";
        is_error();
        print(json_response['message']);
        isnot_loading();
      }
    }else{
      errormsg = "25";
      is_error();
      isnot_loading();
    }

   }
}