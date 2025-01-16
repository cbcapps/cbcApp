import 'package:get/get.dart';

class Clanding_controller extends GetxController{
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    print('tap: ${index}');
    update();
  }



}