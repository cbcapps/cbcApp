import 'package:get/get.dart';
import 'package:ui_ecommerce/main.dart';

class FirstController extends GetxController{
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    print('tap: ${index}');
    update();
  }
}