import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';


class Delivery_controller extends GetxController{
  List<String> governorates_en = [
    'Baghdad',
    'Basra',
    'Dhi Qar',
    'Wasit',
    'Maysan',
    'Muthanna',
    'Karbala',
    'Najaf',
    'Qadisiyah',
    'Babil',
    'Diyala',
    'Salah ad-Din',
    'Kirkuk',
    'Nineveh',
    'Erbil',
    'Dohuk',
    'Sulaymaniyah',
    'Al-Anbar',
  ];
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
  late TextEditingController name  = TextEditingController();
  late TextEditingController address  = TextEditingController();
  late TextEditingController phone  = TextEditingController();
  late TextEditingController note  = TextEditingController();
 void changeSelect(value){
   selectedGovernorate = value;
   update();
 }
 @override
  void onInit() {
   var sharePhone = sharedPreferences.getInt('phone')!;;
   print('${sharePhone} is phone');
   gonvernorates = governorates_ar;
   name.text =  sharedPreferences.getString('name')!;;
   phone.text = sharePhone.toString();
   //phone.text = ;
    // TODO: implement onInit
    super.onInit();
  }


}