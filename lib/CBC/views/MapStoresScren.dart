import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Home_controller.dart';
import 'package:ui_ecommerce/res/colors.dart';

import '../../res/height_width_cus.dart';
import '../../res/images_path.dart';
import '../widgets/joint_widgets/appbar_shoping_ofers_page_cus.dart';
import '../widgets/lacation/open_street_cus.dart';
import '../widgets/loading_widget/progress_circular_cus.dart';

class MapStoresScren extends StatelessWidget {
  MapStoresScren({super.key});

  final Chome_controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarShopingOfersPageCustom(
        AppImages.logoCbcEmpty,
        '217'.tr,
        Get.height * 0.03,
        Get.width * 0.1,
        Container(),
        Container(),
        true,
        false,
      ),
      body: Obx(
        () => mainWidget(context),
      ),
    );
  }

  mainWidget(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          // borderRadius: BorderRadius.circular(Get.width * 0.05),
          child: FlutterMapPuplicJointCustom(
            // initialCenterCus: LatLng(33.3045585, 44.3421706),
            initialCenterCus: _controller.initCenter.value,
            // initialCenterCus: LatLng(7.785834, -122.406417),
            // initialZoomCus: 10,
            markers: _controller.markersStore,
          ),
        ),
        _controller.isLoadingMap.value
            ? const ProgressCircularWidgetCustom()
            : SizedBox.shrink(),
        Container(
            height: heightAppBarCustom(context) * 0.045,
            margin: EdgeInsets.only(top: Get.height * 0.02),
            // color: Colors.amber,
            child: Obx(
              () => _controller.isLoadingCategory.value
                  ? ProgressCircularWidgetCustom()
                  : buildWidgetCategory(),
            )),
      ],
    );
    // end Method
  }

  buildWidgetCategory() {
    return GetBuilder<Chome_controller>(builder: (_) {
      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        controller: _controller.scrollControllerCategoryLang,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _controller.listCategoryLang.length + 1,
        itemBuilder: (context, index) {
          if (_controller.listCategoryLang.length == index) {
            return _controller.loadingPaginationCategoryLang.value
                ? ProgressCircularWidgetCustom()
                : Container();
          } else {
            final category = _controller.listCategoryLang[index];
            final isSelcted = index == _controller.selctedCategory;
            return GestureDetector(
              onTap: () {
                _controller.chosecategoryLang(category.title, index);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.035,
                    vertical: Get.height * 0.005),
                decoration: BoxDecoration(
                  color: isSelcted ? AppColors.cbcColor : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(Get.width * 0.035),
                ),
                alignment: Alignment.center,
                child: Text(
                  // 'data',
                  category.title,
                  style: TextStyle(
                      fontSize: Get.width * 0.035,
                      color: isSelcted ? Colors.white : Colors.grey.shade800,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
        },
      );
    });
    // end Method
  }
  // end Class
}



/*
  [
                Marker(
                  point: LatLng(33.2833904, 44.3936062),
                  width: 80,
                  height: 80,
                  child:
                      //  IconButton(
                      //   splashRadius: 4,
                      //   onPressed: () {
                      //     print('\n');
                      //     print('Have Ben Taped 1');
                      //     print('\n');
                      //   },
                      //   icon:
                      Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Ali',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ],
                  ),
                  // ),
                ),
                Marker(
                  point: LatLng(33.2509483, 44.387257),
                  // width: 80,
                  // height: 80,
                  child: Container(
                    color: Colors.amber,
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: Get.width * 0.11,
                    ),
                  ),
                ),
              ],
*/ 