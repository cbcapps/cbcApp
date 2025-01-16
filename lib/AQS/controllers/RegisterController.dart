import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/Services/RemoteServices.dart';
class RegisterController extends GetxController{

  List<String> governorates_ar = [
    'بغداد',
    'البصرة',
    'ذي قار',
    'واسط',
    'ميسان',
    'المثنى',
    'كربلاء',
    'النجف',
    'القادسية',
    'بابل',
    'ديالى',
    'صلاح الدين',
    'كركوك',
    'نينوى',
    'اربيل',
    'دهوك',
    'السليمانية',
    'الانبار',
  ];
  List<String> gonvernorates = [];
  String? selectedGovernorate ;
  //variable for check Remember me
  late bool isremember = false;
  late bool loading = false;
  late bool errorRegister = false;
  var successRegister = false.obs;
  late String errormsg = '';
  late TextEditingController nameController  = TextEditingController();
  late TextEditingController phoneController  = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController passwordConfirmController  = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  //void for check Remember me
  void changeSelect(value){
    selectedGovernorate = value;
    update();
  }
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
    errorRegister = true;
    update();
  }
  void register() async{
    is_loading();

    var response = await RemoteServices.register(
        nameController.text.trim() ,
        phoneController.text.trim() ,
        selectedGovernorate ,
        addressController.text.trim() ,
        passwordController.text.trim()
    );
    if(response != null){
      var json_response = jsonDecode(response);
      if(json_response['message'] == "Register Successfully"){
        successRegister(true);
        isnot_loading();
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
  @override
  void onInit() {
    gonvernorates = governorates_ar;
    // TODO: implement onInit
    super.onInit();
  }

}