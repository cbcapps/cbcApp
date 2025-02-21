import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/height_width_cus.dart';
import '../../res/images_path.dart';
import '../controllers/FavoriteUserItemsControler.dart';

import '../widgets/joint_widgets/appbar_shoping_ofers_page_cus.dart';
import '../widgets/loading_widget/progress_circular_cus.dart';
import '../widgets/shoping_page/item_sliver_list_cus.dart';

class FavoriteShopingItemScreen extends StatelessWidget {
  FavoriteShopingItemScreen({super.key});

  // final Shopingcontroller _shopingController = Get.find();
  final FavoriteUserItemsControler _controler = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarShopingOfersPageCustom(
        AppImages.logoCbcEmpty,
        '',
        Get.height * 0.03,
        Get.width * 0.1,
        Container(),
        Container(),
        true,
        false,
      ),
      body: Container(
        // color: Colors.amber,
        child: ListView(
          padding: EdgeInsets.only(
            top: heightAppBarCustom(context) * 0.025,
            right: Get.width * 0.045,
            left: Get.width * 0.045,
          ),
          children: [
            // 0.975
            SizedBox(
              // color: Colors.amber,
              height: heightAppBarCustom(context) * 0.04,
              child: Text(
                'المتاجر المفضلة',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Get.width * 0.05,
                ),
              ),
            ),
            //  height: heightAppBarCustom(context) * 0.04,
            GetBuilder<FavoriteUserItemsControler>(
              builder: (_) {
                return Container(
                  // color: Colors.amberAccent,
                  // height: Getheight * 0.46,
                  height: heightAppBarCustom(context) * 0.9,
                  child: _controler.isLoadingFavoritePage
                      ? const ProgressCircularWidgetCustom()
                      : _controler.listShopingUserFavorite.isNotEmpty
                          ? buildItemsShoping()
                          : Center(
                              child: Text('${'20'.tr}'),
                            ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  buildItemsShoping() {
    return RefreshIndicator(
      onRefresh: () async {
        await _controler.fetchAllShoppingStoreFavoriteUser();
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _controler.scrollControllerFavoriteUser,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                bool check =
                    index == (_controler.listShopingUserFavorite.length);

                if (index >= _controler.listShopingUserFavorite.length) {
                  // return Container(
                  //   height: 100,
                  //   color: Colors.red,
                  // );
                  return Obx(
                    () => _controler.loadingPaginationFavoritePage.value
                        ? Column(
                            children: [
                              ProgressCircularWidgetCustom(),
                              SizedBox(
                                height: Get.height * 0.04,
                              )
                            ],
                          )
                        : SizedBox.shrink(),
                  );
                } else {
                  print('\n');
                  print(
                      'Screen the index = $index and Lenght is ${_controler.listShopingUserFavorite.length}');
                  print('\n');
                  final itemShoping = _controler.listShopingUserFavorite[index];
                  return ItemSliverListCustom(
                    isIndexZero: index == 0,
                    onTapFacbook: () {
                      _controler.openurl(itemShoping.facebook);
                    },
                    onTapInstgram: () {
                      _controler.openurl(itemShoping.instagram);
                    },
                    checkLastItem: check,
                    shoppingModel: itemShoping,
                    isFavorite: itemShoping.isFavorite == 1,
                    onTapFavorite: () {
                      _controler
                          .removeItemFromListShopingFavorite(itemShoping.id);
                    },
                  );
                }
              },
              childCount: _controler.listShopingUserFavorite.length + 1,
            ),
          ),
        ],
      ),
    );
    // end Method
  }
}
