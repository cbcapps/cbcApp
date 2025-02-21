import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Home_controller.dart';
import 'package:ui_ecommerce/CBC/views/StorePage.dart';
import '../../res/colors.dart';
import '../../res/method_utls.dart';
import '../widgets/loading_widget/progress_circular_cus.dart';

class HieghestStoresdDinar extends StatelessWidget {
  HieghestStoresdDinar({super.key});
  final Chome_controller controller = Get.put(Chome_controller());

  @override
  Widget build(BuildContext context) {
    print('\n');
    print('----------------------------====================================');
    print('\n');
    print('The  Page 15 Dinnar ');
    print('\n');
    print('----------------------------====================================');
    print('\n');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.cbcColor,
        leading: IconButton(
          // borderRadius: BorderRadius.circular(30),
          onPressed: () {
            Get.back();
          },
          icon: Container(
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
        centerTitle: true,
        title: Text(
          '91'.tr,
          style: TextStyle(
              color: Colors.white,
              fontSize: Get.width * 0.04,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // controller.fetchHighest();
          controller.onRefreshFetchHighestDiscountDinnar();
        },
        child: Obx(() {
          if (!controller.isLoadingHighestDinnar.value) {
            if (controller.highestListDinnar.isNotEmpty) {
              return Container(
                height: Get.height,
                width: Get.width,
                margin: EdgeInsets.only(bottom: Get.height * 0.02),
                color: Colors.white,
                child: stories(),
              );
            } else {
              print('not data');
              return Center(
                child: Text('${'20'.tr}'),
              );
            }
          } else {
            return Center(
              child: SpinKitWave(
                color: AppColors.cbcColor,
                size: Get.width * 0.1,
              ),
            );
          }
        }),
      ),
    );
  }

  stories() {
    return GridView.builder(
      controller: controller.scrollControllerHeighestDicontDinnar,
      padding: EdgeInsets.only(
          left: Get.height * 0.01,
          right: Get.height * 0.01,
          top: Get.height * 0.01),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1.1,
      ),
      itemCount: controller.highestListDinnar.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (controller.highestListDinnar.length == index) {
          return Obx(
            () => controller.loadingPaginationHeightestDiscontDinnar.value
                ? ProgressCircularWidgetCustom()
                : Container(),
          );
        } else {
          print('\n');
          print(
              'Scree Dinnar index is $index And Lenght is ${controller.highestListDinnar.length}');
          print('\n');
          final Item = controller.highestListDinnar[index];
          return DiscountItem(
              Item.image, Item.store, Item.storeId, Item.discount);
        }
      },
    );
  }

  DiscountItem(String url, String label, int id, double discount) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StorePage(), arguments: [
          {"id": id}
        ]);
        //Get.toNamed('/products' , arguments: [{'id':id}]);
      },
      child: Container(
          // padding: EdgeInsetsDirectional.only(
          //     start: Get.height * 0.01, end: Get.height * 0.01),
          child: Container(
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.all(Get.height * 0.01),
        width: Get.height * 0.25,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              // decoration: const BoxDecoration(
              //     color: Colors.amber,
              //     borderRadius: BorderRadius.all(Radius.circular(15))),
              // Old One
              // height: Get.height * 0.08,
              // width: Get.height * 0.08,
              height: Get.height * 0.1,
              width: Get.width * 0.4,
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(45.0),
                borderRadius: BorderRadius.circular(Get.width * 0.03),
                child: CachedNetworkImage(
                  imageUrl: url,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const ProgressCircularWidgetCustom(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.008,
            ),
            SizedBox(
              child: Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: Get.height * 0.013)),
            ),
            SizedBox(
              height: Get.height * 0.003,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '95'.tr,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  // ' ${discount} ',
                  MethodsClassUTls.formatNumber(number: discount) + '220'.tr,

                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.cbcRed,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.height * 0.018),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
