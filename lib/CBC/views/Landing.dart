import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/CBC/views/Card.dart';
import 'package:ui_ecommerce/CBC/views/Cities.dart';
import 'package:ui_ecommerce/CBC/views/First_cbc.dart';
import 'package:ui_ecommerce/CBC/views/Home.dart';
class Landing_cbc extends StatelessWidget {
   Landing_cbc({super.key});
   final Clanding_controller controller = Get.put(Clanding_controller());
  static  final List<Widget> _pages = <Widget>[
    First_cbc(),
    Home_cbc(),
    Cities_view(),
    CardView(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Clanding_controller>(builder: (c){
      return _pages.elementAt(c.selectedIndex);
    },);
  }
}

