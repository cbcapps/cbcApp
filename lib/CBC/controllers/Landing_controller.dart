import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/Card.dart';
import '../views/Cities.dart';
import '../views/First_cbc.dart';
import '../views/Home.dart';

class Clanding_controller extends GetxController {
  List<Widget> pages = <Widget>[
    First_cbc(),
    Home_cbc(),
    Cities_view(),
    CardView(),
  ];

  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    print('tap: ${index}');
    update();
  }
}
