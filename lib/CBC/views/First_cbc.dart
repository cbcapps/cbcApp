import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/AllCategoriesController.dart';
import 'package:ui_ecommerce/CBC/controllers/Home_controller.dart';
import 'package:ui_ecommerce/CBC/controllers/Landing_controller.dart';
import '../../main.dart';
import '../../res/colors.dart';
class First_cbc extends StatelessWidget {
   First_cbc({super.key});
   final AllCategoriesController Categorycontroller = Get.put(AllCategoriesController());
   final Chome_controller HomeController = Get.put(Chome_controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Image.asset(
            'assets/images/panel_cbc.png',
            width: Get.height * 0.35,
            height: Get.height * 0.25,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '81'.tr,
                  style: TextStyle(
                    fontSize: Get.height * 0.04,
                    color: AppColors.cbcColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '82'.tr,
                  style: TextStyle(
                    fontSize: Get.height * 0.04,
                    color: AppColors.cbcRed, // تحديد اللون المختلف هنا
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '83'.tr,
                  style: TextStyle(
                    fontSize: Get.height * 0.04,
                    color: AppColors.cbcColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Container(
            margin: EdgeInsetsDirectional.only(end: Get.height * 0.12),
            alignment: Alignment.centerRight,
            padding: EdgeInsetsDirectional.only(start: Get.height * 0.06 , top: Get.height * 0.02 , bottom: Get.height * 0.02  ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.cbcColor,
                ),
                borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(20)),
                color: AppColors.cbcColor
            ),
            child: Text(
              '84'.tr,
              style: TextStyle(
                fontSize: Get.height * 0.015,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: Get.height * 0.06 , left:  Get.height * 0.13 , right:  Get.height * 0.13),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 GestureDetector(
                   onTap: (){
                     locale_controller.changelocale('ar');
                   },
                   child: Container(
                     height: Get.height * 0.04,
                     width: Get.height * 0.08,
                     decoration: BoxDecoration(
                         border: Border.all(
                           color: AppColors.cbcColor,
                         ),
                         borderRadius: BorderRadius.all( Radius.circular(10)),
                         color: AppColors.cbcColor
                     ),
                     child: Center(
                       child: Text(
                         '85'.tr,
                         style: TextStyle(
                           fontSize: Get.height * 0.012,
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),
                   ),
                 ),
                  //
                 GestureDetector(
                   onTap: (){
                     locale_controller.changelocale('ckb');
                   },
                   child:  Container(
                     height: Get.height * 0.04,
                     width: Get.height * 0.08,
                     decoration: BoxDecoration(
                         border: Border.all(
                           color: AppColors.cbcColor,
                         ),
                         borderRadius: BorderRadius.all( Radius.circular(10)),
                         color: AppColors.cbcColor
                     ),
                     child: Center(
                       child: Text(
                         '86'.tr,
                         style: TextStyle(
                           fontSize: Get.height * 0.012,
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),
                   ),
                 )
                ],
              ),
            ),
          ),

          Obx(() {
            final categoryLoading = Categorycontroller.isFilter.value;
            final homeLoading = HomeController.isLoadingSliders.value;
            final recentlyLoading = HomeController.isLoadingRecently.value;
            final highlestLoading = HomeController.isLoadingHighest.value;
            final citiesLoading = HomeController.isLoadingCities.value;
            if (!categoryLoading || !homeLoading || !recentlyLoading || !highlestLoading || !citiesLoading) {
              return Padding(
                padding: EdgeInsets.only(
                  top: Get.height * 0.06,
                  left: Get.height * 0.15,
                  right: Get.height * 0.15,
                ),
                child: GetBuilder<Clanding_controller>(
                  builder: (c) {
                    return GestureDetector(
                      onTap: () {
                        c.onItemTapped(1);
                      },
                      child: Center(
                        child: Container(
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.cbcColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.cbcColor,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: Get.height * 0.018,
                                ),
                                Text(
                                  '87'.tr,
                                  style: TextStyle(
                                    fontSize: Get.width * 0.028,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(
                  top: Get.height * 0.06,
                  left: Get.height * 0.15,
                  right: Get.height * 0.15,
                ),
                child: Center(
                  child: Container(
                    height: Get.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.cbcColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.cbcColor,
                    ),
                    child: Center(
                      child: SpinKitWave(
                        color: Colors.white,
                        size: Get.width * 0.05,
                      ),
                    ),
                  ),
                ),
              );
            }
          }),


          SizedBox(
            height: Get.height * 0.01,
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.bottomCenter,
            child: Text(
              'الاصدار : 1.0.0',
              style: TextStyle(
                fontSize: Get.height * 0.013,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
