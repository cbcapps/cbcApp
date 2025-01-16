import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/locale/Locale_controller.dart';
import 'package:ui_ecommerce/AQS/views/Cart.dart';
import 'package:ui_ecommerce/AQS/views/Categories.dart';
import 'package:ui_ecommerce/AQS/views/Home.dart';
import 'package:ui_ecommerce/AQS/views/Profile.dart';
import '../../main.dart';
import '../../res/colors.dart';
import '../controllers/FirstController.dart';
import 'Billing.dart';
class Landing extends StatelessWidget {
   Landing({super.key});

   final Landing_controller controller =  Get.find();
   final locale_controller = Get.put(Locale_controller());
   static  final List<Widget> _pages = <Widget>[
     Home_AQS(),
     Categories(),
     CartPage(),
     Billing(),
     Profile()
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: menuBottom(),
      body: GetBuilder<Landing_controller>(builder: (c){
        return _pages.elementAt(c.selectedIndex);
      },),
    );
  }
   menuBottom(){
     return CurvedNavigationBar(
       height: Get.height * 0.08,
       color: AppColors.aqsfullGreen,
       buttonBackgroundColor: AppColors.aqsyallow,
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
             child: Icon(Icons.shopping_cart_outlined , color: Colors.white,size: Get.width * 0.05,),
             label: '16'.tr,
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
             child: Icon(Icons.reorder , color: Colors.white,size: Get.width * 0.05,),
             label: '69'.tr,
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
       index: controller.selectedIndexMenut,
       onTap: (index) {
         FirstController firstController = Get.put(FirstController());
         switch (index) {
           case 0:
             controller.onItemTapped(1);
             print('ok');
             break;
           case 1:
             controller.onItemTapped(2);
           case 2:
             controller.onItemTapped(0);
             break;
           case 3:
             (sharedPreferences.getBool('remember') == true) ? controller.onItemTapped(3) : firstController.onItemTapped(1);
             break;
           case 4:
             (sharedPreferences.getBool('remember') == true) ?  controller.onItemTapped(4) :  firstController.onItemTapped(1);

             break;

         }
         print(index);

         // Handle button tap
       },
     );
   }
   SizedBox spaceH(double size) {
     return SizedBox(
       height: size,
     );
   }
   SizedBox spaceW(double size) {
     return SizedBox(
       width: size,
     );
   }
   Padding actions() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01 , end: Get.height * 0.02),
       child: Row(
         children: [
           spaceW(Get.height * 0.01),
           const Icon(Icons.notifications_outlined),
           spaceW(Get.height * 0.01),
            GestureDetector(
              onTap: (){
                Get.toNamed('favorites');
              },
              child: Icon(Icons.favorite_border_outlined),
            ),
           spaceW(Get.height * 0.01),
           GestureDetector(
             onTap: (){
              controller.onItemTapped(2);
             },
             child: Icon(Icons.shopping_cart_outlined),
           ),
           spaceW(Get.height * 0.01),

         ],
       ),
     );
   }
   Padding logo() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01),
       child: Row(
         children: [
           GetBuilder<Landing_controller>(builder: (builder){
             return GestureDetector(
               onTap: (){
                 builder.openDrawer();
               },
               child: const Icon(Icons.menu),
             );
           }),
           Image.asset('assets/images/logo.png' , fit: BoxFit.fill,width: Get.height * 0.06,height: Get.height * 0.03,),
           Text('0'.tr , style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: Get.height * 0.018
           ),)
         ],
       ),

     );
   }
   drawer() {
     return Container(
       color: Colors.white,
       child: ListView(
         padding: EdgeInsets.zero,
         children: [
           DrawerHeader(

               decoration: const BoxDecoration(
                 color: Colors.white,
               ),
               child: Center(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Image.asset('assets/images/logo.png' ,
                       width: Get.height * 0.2,
                       height: Get.height * 0.1,
                     ),
                     spaceH(Get.height * 0.009),
                     Text('${'2'.tr} ${controller.username}',
                       style: TextStyle(
                           fontSize: Get.height * 0.02,
                           fontWeight: FontWeight.w600
                       ),)
                   ],
                 ),
               )
           ),
           ListTile(
             leading: const Icon(Icons.home_outlined),
             title: Text('14'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(0);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.category_outlined),
             title: Text('15'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(1);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.shopping_cart_outlined),
             title: Text('16'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(2);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.view_list),
             title: Text('69'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               Get.toNamed('/billing');
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.person_outlined),
             title: Text('17'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(3);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.favorite_outline),
             title: Text('60'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               Get.toNamed('/favorites');
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.notifications_outlined),
             title: Text('61'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.onItemTapped(0);
               controller.closeDrawer();
             },
           ),
           ListTile(
             leading: const Icon(Icons.call),
             title: Text('21'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {

             },
           ),
           ListTile(
             leading: const Icon(Icons.language),
             title: Text('22'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               //locale_controller.changelocale();
             },
           ),
           ListTile(
             leading: const Icon(Icons.logout),
             title: Text('23'.tr , style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: Get.height * 0.017
             ),),
             onTap: () {
               controller.logou();
             },
           ),
         ],
       ),
     );
   }
}

