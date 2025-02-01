import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/res/colors.dart';

import '../../res/height_width_cus.dart';
import '../controllers/ShopingController.dart';
import '../widgets/loading_widget/progress_circular_cus.dart';
import '../widgets/shoping_page/item_sliver_list_cus.dart';

class SearchShopingScrn extends StatelessWidget {
  SearchShopingScrn({super.key});
  final Shopingcontroller _shopingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GetBuilder<Shopingcontroller>(builder: (_) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            // top: heightAppBarCustom(context) * 0.03,
            left: Get.width * 0.045,
            right: Get.width * 0.045,
          ),
          // height: Getheight * 0.46,
          height: heightAppBarCustom(context) * 1,
          child: _shopingController.isLoadingSearch
              ? const ProgressCircularWidgetCustom()
              : _shopingController.listShopingSearch.isNotEmpty
                  ? buildItemsShoping()
                  : Center(
                      child: Text('${'20'.tr}'),
                    ),
        );
      }),
    );
  }

  buildItemsShoping() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),

      // controller: _shopingController.scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              bool check =
                  index == (_shopingController.listShopingSearch.length);

              if (index == _shopingController.listShopingSearch.length) {
                // return Container(
                //   height: 100,
                //   color: Colors.red,
                // );
                return Obx(
                  () => _shopingController.loadingPaginationSearch.value
                      ? Column(
                          children: [
                            ProgressCircularWidgetCustom(),
                            SizedBox(
                              height: Get.height * 0.04,
                            )
                          ],
                        )
                      : Container(),
                );
              }
              final itemShoping = _shopingController.listShopingSearch[index];
              return ItemSliverListCustom(
                isIndexZero: index == 0,
                onTapFacbook: () {
                  _shopingController.openurl(itemShoping.facebook);
                },
                onTapInstgram: () {
                  _shopingController.openurl(itemShoping.instagram);
                },
                checkLastItem: check,
                shoppingModel: itemShoping,
                // isFavorite: index % 2 == 0 ? true : false,
                isFavorite: itemShoping.isFavorite == 1,
                // isFavorite: _shopingController.isFavorite,
                onTapFavorite: () {
                  _shopingController
                      .changeShopingIsFavoriteSearchList(itemShoping.id);
                },
              );
            },
            childCount: _shopingController.listShopingSearch.length + 1,
          ),
        ),
      ],
    );
    // end Method
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.cbcColor,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        padding: EdgeInsets.zero,
        icon: Container(
          // color: Colors.amber,
          width: Get.width * 0.065,
          height: Get.height * 0.035,
          // color: Colors.amber,
          margin: EdgeInsetsDirectional.only(end: Get.width * 0.01),
          child: Icon(
            Icons.arrow_back_ios_new_rounded, // Back arrow icon
            color: Colors.white, // Change the color here
            size: Get.width * 0.06,
          ),
        ),
      ),
      title: Container(
        height: Get.height * 0.05,
        child: TextField(
          onChanged: (value) async {
            print('\n');
            print('======================');
            print('The Searhc is $value');
            await _shopingController.calledSearchShopingMethod(value);
          },
          cursorColor: Colors.white,
          style: TextStyle(fontSize: Get.height * 0.015, color: Colors.white),

          // readOnly: true,
          decoration: InputDecoration(
            hintText: '197'.tr,
            fillColor: Colors.blue.withOpacity(0.5),
            contentPadding: EdgeInsets.only(
              top: Get.height * 0.005,
              left: Get.width * 0.03,
              right: Get.width * 0.03,
            ),
            // fillColor: AppColors.cbcRed.withOpacity(0.1),
            filled: true,
            hintStyle:
                TextStyle(fontSize: Get.height * 0.015, color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(Get.width * 0.05)),
              borderSide: BorderSide(
                color: AppColors.cbcColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(Get.width * 0.05)),
              borderSide: BorderSide(
                color: AppColors.cbcColor,
              ),
            ),
            suffixIcon: Container(
              child: Icon(Icons.search,
                  color: Colors.white, size: Get.height * 0.03),
            ),
          ),
        ),
      ),
    );
    // end Method
  }
  // end Class
}
