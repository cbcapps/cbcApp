import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/AccountController.dart';
import 'package:ui_ecommerce/CBC/views/ActiveAcount.dart';
import 'package:ui_ecommerce/CBC/views/MyAccount.dart';
import 'package:ui_ecommerce/CBC/widgets/joint_widgets/appbar_shoping_ofers_page_cus.dart';
import 'package:ui_ecommerce/res/images_path.dart';

import '../../res/colors.dart';

class Account extends StatelessWidget {
  Account({super.key});
  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    print('\n');
    print('----------------------------====================================');
    print('\n');
    print('The Cart Page 1');
    print('\n');
    print('----------------------------====================================');
    print('\n');
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: null, // Navigation bar color
        systemNavigationBarIconBrightness: null, // Icon brightness
      ),
      child: Scaffold(
        appBar: appBarShopingOfersPageCustom(
            AppImages.logoCbcEmpty,
            '17'.tr,
            Get.height * 0.03,
            Get.width * 0.1,
            Container(),
            Container(),
            true,
            false),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TabsPages(),
              PagesTabs(),
            ],
          ),
        ),
      ),
    );
  }

  TabsPages() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: Get.width * 0.04,
          start: Get.width * 0.05,
          end: Get.width * 0.05),
      child: TabBar(
        indicatorColor: Colors.white,

        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: false,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.cbcColor,
        ),
        indicatorWeight: 0.0, // تعيين الوزن إلى 0.0 لإزالة الخط
        labelStyle: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Tajawal'),
        unselectedLabelStyle: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Tajawal'),
        controller: controller.tabController,
        tabs: [
          Tab(text: '120'.tr),
          Tab(text: '121'.tr),
        ],
      ),
    );
  }

  PagesTabs() {
    return Expanded(
      child: GetBuilder<AccountController>(
        builder: (builder) {
          return TabBarView(
            controller: controller.tabController,
            children: [
              MyAccount(),
              ActiveAcount(),
            ],
          );
        },
      ),
    );
  }
}
