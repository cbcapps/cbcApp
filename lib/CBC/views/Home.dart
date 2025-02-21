import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Home_controller.dart';
import 'package:ui_ecommerce/CBC/views/Cities.dart';
import 'package:ui_ecommerce/CBC/views/HomeView.dart';
import 'package:ui_ecommerce/res/colors.dart';
import 'package:ui_ecommerce/res/images_path.dart';

import '../controllers/Landing_controller.dart';
import 'OffersScren.dart';
import 'ShoppingScren.dart';

class Home_cbc extends StatelessWidget {
  Home_cbc({super.key});
  final Chome_controller chome_controller = Get.put(Chome_controller());
  // final Clanding_controller _clanding_controller = Get.find();

  final List<Widget> pages = <Widget>[
    ShoppingScreen(),
    HomeView(),
    OffersScreen(),
    Cities_view(),
    // CardView(),
    // Account(),
    // Help(),
    // AllCategories(),
  ];
  @override
  Widget build(BuildContext context) {
    print('\n');
    print('----------------------------====================================');
    print('\n');
    print('The  Page 16 ');
    print('\n');
    print('----------------------------====================================');
    print('\n');
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.cbcColor, // Navigation bar color
        systemNavigationBarIconBrightness: Brightness.light, // Icon brightness
        // statusBarColor: Colors.transparent, // Transparent status bar
        // statusBarIconBrightness: Brightness.dark, // Status bar icon brightness
      ),
      child: GetBuilder<Clanding_controller>(builder: (c) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            print('\n');
            print('The Edits is $didPop and Object is $result');
            print('\n');

            c.onItemTapped(0);

            // _clanding_controller.pages.elementAt(0);
            // pages.elementAt(0);
          },
          child: Scaffold(
              bottomNavigationBar: menuBottom(),
              body: GetBuilder<Chome_controller>(builder: (c) {
                return pages.elementAt(c.selectedIndex);
              })),
        );
      }),
    );
  }

  menuBottom() {
    return CurvedNavigationBar(
      height: Get.height * 0.08,
      color: AppColors.cbcColor,
      buttonBackgroundColor: AppColors.cbcColor,
      backgroundColor: Colors.white,
      // iconPadding: 14,

      items: [
        CurvedNavigationBarItem(
            child: Container(
              // color: Colors.red,
              // width: Get.width * 0.06,
              // height: Get.height * 0.04,
              width: Get.width * 0.075,
              height: Get.height * 0.045,
              // child: Image.asset(AppImages.shopingPng),
              child: SvgPicture.asset(
                // 'assets/images/shoping.svg',
                AppImages.shopingIcon,
                fit: BoxFit.cover,
              ),
            ),
            label: '196'.tr,
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.014,
                fontWeight: FontWeight.bold)),
        CurvedNavigationBarItem(
            child: Container(
              // color: Colors.amberAccent,
              width: Get.width * 0.095,
              height: Get.height * 0.05,
              // child: Image.asset(AppImages.logoCBC),
              child: SvgPicture.asset(
                // 'assets/images/cbc_main_button.svg',
                AppImages.logoCbcEmpty,
                fit: BoxFit.cover,
              ),
            ),
            // label: '10'.tr,
            label: '14'.tr,
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.014,
                fontWeight: FontWeight.bold)),
        CurvedNavigationBarItem(
          child: SizedBox(
            // width: Get.width * 0.07,
            // height: Get.height * 0.04,
            width: Get.width * 0.075,
            height: Get.height * 0.045,
            // child: Image.asset(AppImages.discountPng),
            child: SvgPicture.asset(
              // 'assets/images/offer_copy.svg',
              AppImages.offerIcon,
              fit: BoxFit.cover,
            ),
          ),
          label: '192'.tr,
          labelStyle: TextStyle(
              color: Colors.white,
              fontSize: Get.height * 0.014,
              fontWeight: FontWeight.bold),
        ),
      ],
      index: 1,
      onTap: (index) {
        switch (index) {
          case 0:
            chome_controller.onItemTapped(0);
            print('ok');
            break;
          case 1:
            // Get.toNamed(PagesName.offerScrn);
            chome_controller.onItemTapped(1);
            break;

          case 2:
            chome_controller.onItemTapped(2);
            break;
        }

        print(index);

        // Handle button tap
      },
    );
  }
}


// Old Ones
// -----------------------------

/*

 [
        CurvedNavigationBarItem(
            child: Icon(
              Icons.category,
              color: Colors.white,
              size: Get.width * 0.04,
            ),
            label: '10'.tr,
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.010,
                fontWeight: FontWeight.bold)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.local_offer,
              color: Colors.white,
              size: Get.width * 0.04,
            ),
            // label: '14'.tr,
            label: '191'.tr,
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.010,
                fontWeight: FontWeight.bold)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.credit_card,
              color: Colors.white,
              size: Get.width * 0.04,
            ),
            label: '150'.tr,
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.010,
                fontWeight: FontWeight.bold)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.home,
              color: Colors.white,
              size: Get.width * 0.04,
            ),
            label: '14'.tr,
            labelStyle: TextStyle(
                color: const Color.fromARGB(255, 231, 132, 132),
                fontSize: Get.height * 0.010,
                fontWeight: FontWeight.bold)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.help,
              color: Colors.white,
              size: Get.width * 0.04,
            ),
            label: '149'.tr,
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.010,
                fontWeight: FontWeight.bold)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: Get.width * 0.04,
            ),
            label: '17'.tr,
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.010,
                fontWeight: FontWeight.bold)),
      ],
*/ 