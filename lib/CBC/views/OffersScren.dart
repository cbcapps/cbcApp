import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/colors.dart';
import '../../res/height_width_cus.dart';
import '../../res/images_path.dart';
import '../controllers/Home_controller.dart';
import '../controllers/OfferesController.dart';
import '../models/OffersModel.dart';
import '../widgets/carsoul_slider_cus.dart';
import '../widgets/joint_widgets/appbar_shoping_ofers_page_cus.dart';
import '../widgets/joint_widgets/notification_widget_cus.dart';
import '../widgets/joint_widgets/pop_menue_home_offer_page_cus.dart';
import '../widgets/loading_widget/progress_circular_cus.dart';
import '../widgets/offers_page/arrange_suction_cus.dart';
import '../widgets/offers_page/item_ofer_grid_view_cus.dart';

class OffersScreen extends StatelessWidget {
  OffersScreen({super.key});
  final Chome_controller controller = Get.find();
  final OffersController _offersController = Get.find();

  @override
  Widget build(BuildContext context) {
    return
        // Stack(
        //   children: [
        Scaffold(
      appBar: appBarShopingOfersPageCustom(AppImages.offerIcon, '192'.tr, 55,
          55, PopMenueHomeOfferPageCustom(), builIconNotifcation(), null, true),
      body: content(context),
    );
  }

  buildDivider() {
    return Divider(color: AppColors.black.withOpacity(0.05), height: 0);
  }

  Widget? builIconNotifcation() {
    return Obx(
      () => NotificationWidgetCustom(
        showCartBadge: controller.showCartBadge.value,
        backgroundMessagesLength: controller.backgroundMessagesLength.value,
      ),
      //
    );
  }

  Widget content(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          // color: Colors.amber,
          margin: EdgeInsetsDirectional.only(
            // top: Getheight * 0.01,
            top: heightNavBarCustom(context) * 0.01,
            bottom: heightNavBarCustom(context) * 0.03,
            // bottom: Getheight * 0.03,
          ),
          child: CarsoulSliderCustom(
            heightCus: heightNavBarCustom(context) * 0.28,
            // heightCus: Getheight * 0.23,
            images: _offersController.listImagesSliders,
            // images: const [
            //   AppImages.error404,
            //   AppImages.appIcon,
            // ],
          ),
        ),

        //  Second Section Of Arrange Items
        Obx(() {
          return ArrangeSuctionCustom(
            arrangeBy: _offersController.orderBy.value,
            onTapDesc: () {
              _offersController.changeOrderBy('desc');
            },
            onTapAsc: () {
              _offersController.changeOrderBy('asc');
            },
          );
        }),

        //  Section Items
        // ---------------
        Obx(() {
          return Container(
            // color: Colors.amber,
            height: heightNavBarCustom(context) * 0.68,
            child: _offersController.isLoading.value
                ? const ProgressCircularWidgetCustom()
                : _offersController.listOffers.isNotEmpty
                    ? buildGridView(context, _offersController.listOffers)
                    : Center(
                        child: Text('${'20'.tr}'),
                      ),
          );
        }),

        // Obx(
        //   () => !_offersController.loadingPagination.value
        //       ? Container(
        //           height: 100,
        //         )
        //       :
        // Center(
        //   child: Container(
        //     margin: EdgeInsets.only(top: 10, bottom: 30),
        //     child: CircularProgressIndicator(
        //       strokeWidth: 6,
        //       color: Colors.amber,
        //       strokeCap: StrokeCap.round,
        //     ),
        //   ),
        // ),
        // ),
      ],
    );
  }

  buildGridView(BuildContext context, RxList<OffersModel> listOfers) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: AppColors.cbcColor,
      onRefresh: () async {
        _offersController.refreshMethod();
      },
      child: GridView.builder(
        itemCount: listOfers.length + 1,
        controller: _offersController.scrollController,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(
            left: Get.width * 0.01,
            right: Get.width * 0.01,
            // top: Getheight * 0.01,
            top: heightNavBarCustom(context) * 0.02,
            bottom: heightNavBarCustom(context) * 0.1),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          if (index >= listOfers.length) {
            // return Container(
            //   height: 100,
            //   color: Colors.red,
            // );
            return Obx(
              () => _offersController.loadingPagination.value
                  ? ProgressCircularWidgetCustom()
                  : Container(),
            );
          } else {
            final item = listOfers[index];

            return ItemOferGridViewCustom(
              offerItem: item,
              onTapLink: () {
                _offersController.openurl(item.link);
              },
            );
          }
        },
      ),
    );
    // end Method
  }

  // End Class
}
