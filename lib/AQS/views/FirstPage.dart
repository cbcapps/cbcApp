import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/FirstController.dart';
import 'package:ui_ecommerce/AQS/views/Landing.dart';
import 'package:ui_ecommerce/AQS/views/Login.dart';
class Landing_aqs extends StatelessWidget {
  Landing_aqs({super.key});
  final FirstController controller = Get.put(FirstController());
  static  final List<Widget> _pages = <Widget>[
    Landing(),
    Login()
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstController>(builder: (c){
      return _pages.elementAt(c.selectedIndex);
    },);
  }
}

