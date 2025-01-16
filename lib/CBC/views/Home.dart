import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Home_controller.dart';
import 'package:ui_ecommerce/CBC/views/Card.dart';
import 'package:ui_ecommerce/CBC/views/Cities.dart';
import 'package:ui_ecommerce/CBC/views/Help.dart';
import 'package:ui_ecommerce/CBC/views/HomeView.dart';
import 'package:ui_ecommerce/res/colors.dart';

import 'AccountView.dart';
import 'AllCategories.dart';
class Home_cbc extends StatelessWidget {
   Home_cbc({super.key});
  final Chome_controller chome_controller = Get.put(Chome_controller());
   final List<Widget> pages = <Widget>[
     HomeView(),
     Cities_view(),
     CardView(),
     Account(),
     Help(),
     AllCategories(),
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  menuBottom(),
      body: GetBuilder<Chome_controller>(builder: (c){
        return pages.elementAt(c.selectedIndex);
      })
    );
  }
   menuBottom(){
     return CurvedNavigationBar(
       height: Get.height * 0.08,
       color: AppColors.cbcColor,
       buttonBackgroundColor: Colors.red,
       backgroundColor: Colors.white,
       items:  [
         CurvedNavigationBarItem(
             child: Icon(Icons.category , color: Colors.white,size: Get.width * 0.05,),
             label: '10'.tr,
             labelStyle: TextStyle(
               color: Colors.white,
               fontSize: Get.height * 0.012,
                 fontWeight: FontWeight.bold
             )
         ),
         CurvedNavigationBarItem(
             child: Icon(Icons.credit_card , color: Colors.white,size: Get.width * 0.05,),
             label: '150'.tr,
             labelStyle: TextStyle(
               color: Colors.white,
               fontSize: Get.height * 0.012,
                 fontWeight: FontWeight.bold
             )
         ),
         CurvedNavigationBarItem(
             child: Icon(Icons.home , color: Colors.white,size: Get.width * 0.05,),
             label: '14'.tr,
             labelStyle: TextStyle(
               color: Colors.white,
               fontSize: Get.height * 0.012,
               fontWeight: FontWeight.bold
             )
         ),
         CurvedNavigationBarItem(
             child: Icon(Icons.help , color: Colors.white,size: Get.width * 0.05,),
             label: '149'.tr,
             labelStyle: TextStyle(
               color: Colors.white,
               fontSize: Get.height * 0.012,
                 fontWeight: FontWeight.bold
             )
         ),
         CurvedNavigationBarItem(
             child: Icon(Icons.person , color: Colors.white,size: Get.width * 0.05,),
             label: '17'.tr,
             labelStyle: TextStyle(
               color: Colors.white,
               fontSize: Get.height * 0.012,
                 fontWeight: FontWeight.bold
             )
         ),
       ],
       index: 2,
       onTap: (index) {

        switch (index) {
          case 0:
            chome_controller.onItemTapped(5);
            print('ok');
            break;
          case 1:
            chome_controller.onItemTapped(2);
          case 2:
            chome_controller.onItemTapped(0);
            break;
          case 3:
            chome_controller.onItemTapped(4);
            break;
          case 4:
            chome_controller.onItemTapped(3);
            break;

        }

         print(index);

         // Handle button tap
       },
     );
   }

}
