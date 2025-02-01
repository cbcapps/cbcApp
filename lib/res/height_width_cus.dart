import 'package:flutter/material.dart';
import 'package:get/get.dart';

double heightNavBarCustom(BuildContext context) {
  double appBarHeight = AppBar().preferredSize.height; // Height of the AppBar
  double bottomNavBarHeight =
      kBottomNavigationBarHeight; // Default height of BottomNavigationBar

  double availableHeight = Get.height -
      appBarHeight -
      bottomNavBarHeight -
      MediaQuery.of(context).padding.top;

  return availableHeight;
}

double heightAppBarCustom(BuildContext context) {
  double appBarHeight = AppBar().preferredSize.height; // Height of the AppBar

  double availableHeight =
      Get.height - appBarHeight - MediaQuery.of(context).padding.top;

  return availableHeight;
}
