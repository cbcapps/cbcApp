import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/CBC/views/Card.dart';
import 'package:ui_ecommerce/CBC/views/Cities.dart';
import 'package:ui_ecommerce/CBC/views/First_cbc.dart';
import 'package:ui_ecommerce/CBC/views/Home.dart';

class Landing_cbc extends StatelessWidget {
  Landing_cbc({super.key});
  final Clanding_controller controller = Get.put(
    Clanding_controller(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    print('\n');
    print('----------------------------====================================');
    print('\n');
    print('The  Page 19 ');
    print('\n');
    print('----------------------------====================================');
    print('\n');
    return GetBuilder<Clanding_controller>(
      builder: (c) {
        return c.pages.elementAt(c.selectedIndex);
      },
    );
  }
}
