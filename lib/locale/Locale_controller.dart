import 'dart:ui';
import 'package:get/get.dart';
import 'package:ui_ecommerce/main.dart';
class Locale_controller extends GetxController {
  Locale inliaLang = sharedPreferences.getString('lang') == 'ckb' ? Locale('ckb', 'IQ') : Locale('ar', 'IQ');

  void changelocale(lang) {
    Locale locale = Locale(lang);
    sharedPreferences.setString('lang', lang);
    Get.updateLocale(locale);
    print(sharedPreferences.getString('lang'));
  }
}