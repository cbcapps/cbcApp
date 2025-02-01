import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Help.dart';
import 'package:ui_ecommerce/CBC/views/InstructionsView.dart';
import 'package:ui_ecommerce/CBC/views/ShareView.dart';
import '../../res/colors.dart';
import '../../res/images_path.dart';
import '../widgets/joint_widgets/appbar_shoping_ofers_page_cus.dart';
import 'CallCenterView.dart';

class Help extends StatelessWidget {
  Help({super.key});
  final HelpController controller = Get.put(HelpController());
  @override
  Widget build(BuildContext context) {
    print('\n');
    print('----------------------------====================================');
    print('\n');
    print('The  Page 14 ');
    print('\n');
    print('----------------------------====================================');
    print('\n');
    return Scaffold(
      appBar: appBarShopingOfersPageCustom(
          AppImages.logoCbcEmpty,
          '149'.tr,
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
        labelStyle: TextStyle(
            fontSize: Get.width * 0.023,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Tajawal'),
        unselectedLabelStyle: TextStyle(
            fontSize: Get.width * 0.023,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Tajawal'),
        controller: controller.tabController,
        tabs: [
          Tab(text: '131'.tr),
          Tab(text: '132'.tr),
          Tab(text: '133'.tr),
        ],
      ),
    );
  }

  PagesTabs() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(bottom: Get.width * 0.07),
      child: GetBuilder<HelpController>(
        builder: (builder) {
          return TabBarView(
            controller: controller.tabController,
            children: [
              CallCenterView(),
              InstructionsView(),
              ShareView(),
            ],
          );
        },
      ),
    ));
  }
}
