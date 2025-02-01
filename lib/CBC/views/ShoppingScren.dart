import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/models/ShoppingModel.dart';
import 'package:ui_ecommerce/res/images_path.dart';
import 'package:ui_ecommerce/res/pages_name.dart';

import '../../res/colors.dart';
import '../../res/height_width_cus.dart';
import '../controllers/Home_controller.dart';
import '../controllers/ShopingController.dart';
import '../widgets/carsoul_slider_cus.dart';
import '../widgets/joint_widgets/appbar_shoping_ofers_page_cus.dart';
import '../widgets/joint_widgets/notification_widget_cus.dart';
import '../widgets/loading_widget/progress_circular_cus.dart';
import '../widgets/shoping_page/item_sliver_list_cus.dart';
import '../widgets/shoping_page/pop_menu_widget_cus.dart';

class ShoppingScreen extends StatelessWidget {
  ShoppingScreen({super.key});

  final Chome_controller homeContrler = Get.put(Chome_controller());
  final Shopingcontroller _shopingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return
        // Stack(
        //   children: [
        Scaffold(
            appBar: appBarShopingOfersPageCustom(
                AppImages.shopingIcon,
                '196'.tr,
                40,
                40,
                PopMenuWidgetCustom(),
                builIconNotifcation(),
                null,
                true),
            body: content(context));
  }

  Widget content(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          // top: Getheight * 0.02,
          top: heightNavBarCustom(context) * 0.02,
          right: Get.width * 0.04,
          left: Get.width * 0.04,
        ),
        children: [
          Row(
            children: [
              // Container(

              //   width: Get.width * 0.75,
              //   // height: Getheight * 0.05,
              //   height: heightNavBarCustom(context) * 0.06,
              //   child: SearchTextInputCustom(
              //     hintTxt: '197'.tr,
              //     controllerCus: _shopingController.myController,
              //     futureFunction: () {
              //       return _shopingController.fetchStoresBySearch();
              //     },
              //     getSelectedValueCus: (value) {
              //       if (value != null) {
              //         TestItem selectedItem = value
              //             as TestItem; // تأكد من أن القيمة هي من نوع TestItem
              //         // Get.to(() => StorePage(), arguments: [
              //         //   {"id": selectedItem.value}
              //         // ]);
              //         print('\n');
              //         print('===========================');
              //         print('\n');
              //         print(
              //             'The Item Shoping Screen , name = ${value.label} and Id = ${value.value} ');
              //         _shopingController.getTheSelctedShop(selectedItem.value);
              //         _shopingController.myController.clear();
              //       }
              //     },
              //   ),
              // ),

              Container(
                width: Get.width * 0.75,
                height: heightNavBarCustom(context) * 0.06,
                // color: Colors.amber,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(PagesName.searchShopingScrn);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.cbcColor),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Text(
                          '197'.tr,
                          style: TextStyle(
                            fontSize: Get.height * 0.015,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: heightNavBarCustom(context) * 0.06,
                          width: Get.width * 0.1,
                          decoration: const BoxDecoration(
                            color: AppColors.cbcColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Icon(Icons.search,
                              color: Colors.white, size: Get.height * 0.03),
                        ),
                      ],
                    ),
                  ),
                  // TextField(
                  //   readOnly: true,
                  //   decoration: InputDecoration(
                  //     hintText: '197'.tr,
                  //     fillColor: Colors.white,
                  //     filled: true,
                  //     hintStyle: TextStyle(
                  //       fontSize: Get.height * 0.015,
                  //     ),
                  //     enabledBorder: const OutlineInputBorder(
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(10),
                  //         bottomLeft: Radius.circular(10),
                  //       ),
                  //       borderSide: BorderSide(
                  //         color: AppColors.cbcColor,
                  //       ),
                  //     ),
                  //     focusedBorder: const OutlineInputBorder(
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(10),
                  //         bottomLeft: Radius.circular(10),
                  //       ),
                  //       borderSide: BorderSide(
                  //         color: AppColors.cbcColor,
                  //       ),
                  //     ),
                  //     suffixIcon: Container(
                  //       decoration: const BoxDecoration(
                  //         color: AppColors.cbcColor,
                  //         borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(10),
                  //           bottomLeft: Radius.circular(10),
                  //         ),
                  //       ),
                  //       child: Icon(Icons.search,
                  //           color: Colors.white, size: Get.height * 0.03),
                  //     ),
                  //   ),
                  // ),
                ),
              ),

              // Spacer(),
              GestureDetector(
                onTap: () {
                  buidlDialogChoseItem(
                      chosenFilter: _shopingController.chosenFilter.value,
                      titleDialog: '213'.tr);
                },
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: Get.width * 0.04),
                  // height: Getheight * 0.05,
                  height: heightNavBarCustom(context) * 0.06,
                  width: Get.width * 0.10,
                  // color: Colors.amber,
                  child: SvgPicture.asset(
                    AppImages.filterSquareBlue,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Container(
            // color: Colors.amber,
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(
              // top: Getheight * 0.01,
              top: heightNavBarCustom(context) * 0.01,
              bottom: heightNavBarCustom(context) * 0.02,
              // bottom: Getheight * 0.02,
            ),
            child: CarsoulSliderCustom(
              // heightCus: Getheight * 0.23,
              heightCus: heightNavBarCustom(context) * 0.25,
              images: _shopingController.listImagesSliders,

              // images: const [
              //   AppImages.error404,
              //   AppImages.appIcon,

              //   // '',
              // ],
            ),
          ),

          // Container(
          //   height: heightNavBarCustom(context) * 0.02,
          //    decoration: BoxDecoration(
          //     // color: Colors.amber,
          //     boxShadow: const [
          //       BoxShadow(
          //         // color: _contrler.isAppBarCollapsed
          //         //     ? Get.isDarkMode
          //         //         ? AppColors.whitebackground.withOpacity(0.1)
          //         //         : Colors.black.withOpacity(0.1)
          //         //     :
          //          color:     Colors.white,
          //         blurRadius: 15,
          //         // spreadRadius: 4,
          //         blurStyle: BlurStyle.outer,
          //         offset: Offset(0, 1),
          //       )
          //     ],
          //   ),
          // ),

          // Section Items
          //  print('List updated: listItem.length');

          GetBuilder<Shopingcontroller>(
            builder: (_) {
              return Container(
                // color: Colors.amberAccent,
                // height: Getheight * 0.46,
                height: heightNavBarCustom(context) * 0.65,
                child: _shopingController.isLoading
                    ? const ProgressCircularWidgetCustom()
                    : _shopingController.listShopingStore.isNotEmpty
                        ? buildItemsShoping()
                        : Center(
                            child: Text('${'20'.tr}'),
                          ),
              );
            },
          )
        ],
      ),
    );
    // end Method
  }

  Widget? builIconNotifcation() {
    return Obx(
      () => NotificationWidgetCustom(
        showCartBadge: homeContrler.showCartBadge.value,
        backgroundMessagesLength: homeContrler.backgroundMessagesLength.value,
      ),
      //
    );
  }

  buildItemsShoping() {
    return RefreshIndicator(
      onRefresh: () async {
        await _shopingController.onRefreshMethod();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _shopingController.scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  bool check =
                      index == (_shopingController.listShopingStore.length);

                  if (index >= _shopingController.listShopingStore.length) {
                    // return Container(
                    //   height: 100,
                    //   color: Colors.red,
                    // );
                    return Obx(
                      () => _shopingController.loadingPagination.value
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
                  ShoppingModel itemShoping =
                      _shopingController.listShopingStore[index];

                  // final isItemFavorite = itemShoping.isFavorite == 1
                  //     ? true
                  //     : _shopingController.checkItemIfFavorite(itemShoping.id);
                  return ItemSliverListCustom(
                    isIndexZero: index == 0,
                    onTapFacbook: () =>
                        _shopingController.openurl(itemShoping.facebook),
                    onTapInstgram: () =>
                        _shopingController.openurl(itemShoping.instagram),
                    checkLastItem: check,
                    shoppingModel: itemShoping,
                    isFavorite: itemShoping.isFavorite == 1,
                    onTapFavorite: () {
                      // _shopingController.addItemToFavorite(itemShoping.id);
                      _shopingController
                          .changeShopingIsFavorite(itemShoping.id);
                    },
                  );
                },
                childCount: _shopingController.listShopingStore.length + 1,
              ),
            ),

            //
            SliverToBoxAdapter(
              child: SizedBox(
                  height: Get.height * 0.1), // Adjust the height as needed
            ),
          ],
        ),
      ),
    );
    // end Method
  }

  void buidlDialogChoseItem({
    required String titleDialog,
    required int chosenFilter,
    // double heightDialog = 170,
    String? isLarge,
  }) {
    //
    final hieghtCus = Get.height * 0.2;
    Get.defaultDialog(
        //
        //
        backgroundColor: Colors.white,
        title: titleDialog,
        titlePadding: EdgeInsets.only(
          top: Get.height * 0.01,
        ),
        contentPadding: EdgeInsets.zero,
        titleStyle: TextStyle(
            // fontSize: 16,
            overflow: TextOverflow.ellipsis,
            fontSize: Get.width * 0.045,
            color: AppColors.black,
            // fontFamily: AppFonts.almaraiBold,
            fontWeight: FontWeight.bold),
        //
        content: SizedBox(
          // color: Colors.red,
          // height: heightDialog,
          height: hieghtCus,
          // width: 350,
          width: Get.width * 0.82,
          child: Column(
            children: [
              //
              // SizedBox(height: 10),
              SizedBox(height: Get.height * 0.01),
              // Divider
              isLarge != null
                  ? Container()
                  : const Divider(
                      height: 0,
                      color: AppColors.black,
                    ),

              // ---------

              GetBuilder<Shopingcontroller>(builder: (_) {
                return SizedBox(
                  height: hieghtCus - 10,
                  // height: hieghtCus ,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _shopingController.listFilters.length,
                      itemBuilder: (context, index) {
                        //
                        final filterItem =
                            _shopingController.listFilters[index];
                        //
                        return InkWell(
                          onTap: () {
                            //

                            // _createNewRequestController
                            //     .changeNDShadeGuideText(item);

                            _shopingController.filterStoreMethod(
                                filterItem.type, filterItem.descAsc, index);

                            //
                            // Back
                            Get.back();
                            //
                            // Change Payment Text
                          },
                          child: Container(
                            // height: 100,
                            color: chosenFilter == index
                                ? AppColors.cbcColor
                                : null,
                            // padding: EdgeInsets.only(bottom: 12.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text
                                // Space
                                // SizedBox(
                                //   height: 10,
                                // ),
                                SizedBox(height: Get.height * 0.01),
                                Text(
                                  filterItem.txt,
                                  style: TextStyle(
                                    // fontSize: 16,
                                    fontSize: Get.width * 0.04,

                                    color: chosenFilter == index
                                        ? Colors.white
                                        : AppColors.black,
                                    // fontFamily: AppFonts.almaraiRegular,
                                    // height: 1.15,
                                  ),
                                ),
                                // Space
                                // SizedBox(
                                //   height: 10,
                                // ),
                                SizedBox(height: Get.height * 0.01),

                                // Divider
                                Divider(
                                  height: 0,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }),
            ],
          ),
        )
        // End Dialog
        );

    // End Method
  }

  // -------------
  // end Class
}
