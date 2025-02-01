import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/res/colors.dart';
import 'package:ui_ecommerce/res/images_path.dart';

import '../../../res/height_width_cus.dart';
import '../../models/ShoppingModel.dart';
import '../joint_widgets/cached_network_image_cus.dart';

class ItemSliverListCustom extends StatelessWidget {
  const ItemSliverListCustom({
    super.key,
    required this.checkLastItem,
    required this.isIndexZero,
    required this.isFavorite,
    required this.onTapFavorite,
    required this.shoppingModel,
    required this.onTapFacbook,
    required this.onTapInstgram,
  });

  final bool isIndexZero;
  final bool checkLastItem;
  final bool isFavorite;
  final void Function()? onTapFavorite;
  final ShoppingModel shoppingModel;
  final void Function()? onTapFacbook;
  final void Function()? onTapInstgram;

  @override
  Widget build(BuildContext context) {
    //
    final checkInstgram = shoppingModel.instagram != null;
    final checkFaceBook = shoppingModel.facebook != null;
    return Container(
      margin: EdgeInsets.only(
        bottom: checkLastItem ? Get.height * 0.2 : Get.height * 0.03,
        top: isIndexZero ? Get.height * 0.03 : 0,
        // left: Get.width * 0.02,
        // right: Get.width * 0.02,
      ),
      decoration: BoxDecoration(
        color: AppColors.grayLight,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: AppColors.black.withOpacity(0.1),
            blurStyle: BlurStyle.normal,
            blurRadius: 1,
            offset: const Offset(0, 0),
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.01),
          sectionNamePercentOfferes(context),
          SizedBox(height: Get.height * 0.005),
          SizedBox(
            height: Get.height * 0.16,
            width: double.infinity,
            // color: Colors.red,
            // child: Image.asset(
            //   AppImages.error404,
            //   fit: BoxFit.fill,
            // ),
            child: Padding(
              // padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              padding: EdgeInsets.zero,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(Get.width * 0.05),
                  child: CachedNetworkImageCustom(image: shoppingModel.logo)),
            ),
          ),
          // Divider(
          //   height: 0,
          //   color: AppColors.black.withOpacity(0.3),
          // ),
          Container(
            margin: EdgeInsets.symmetric(vertical: Get.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Container(
                    //   height: 30,
                    //   width: 30,
                    //   // color: Colors.red,
                    //   child: SvgPicture.asset(AppImages.whatsapp),
                    // ),
                    // SizedBox(
                    //   width: Get.width * 0.05,
                    // ),
                    // Container(
                    //   height: 26,
                    //   width: 26,
                    //   // color: Colors.blue,
                    //   child: SvgPicture.asset(AppImages.tikTok),
                    // ),
                    // SizedBox(
                    //   width: Get.width * 0.05,
                    // ),

                    checkInstgram
                        ? InkWell(
                            onTap: onTapInstgram,
                            child: SizedBox(
                              // height: 26,
                              // width: 26,
                              height: Get.height * 0.03,
                              width: Get.width * 0.065,
                              // color: Colors.blue,
                              // color: Colors.blue,
                              child: SvgPicture.asset(AppImages.instgram),
                            ),
                          )
                        : SizedBox.shrink(),
                    checkInstgram
                        ? SizedBox(
                            width: Get.width * 0.05,
                          )
                        : SizedBox.shrink(),

                    checkFaceBook
                        ? InkWell(
                            onTap: onTapFacbook,
                            child: SizedBox(
                              // height: 24,
                              // width: 24,
                              height: Get.height * 0.03,
                              width: Get.width * 0.06,
                              // color: Colors.blue,
                              child: SvgPicture.asset(AppImages.facebook),
                            ),
                          )
                        : Container(),
                  ],
                ),
                // Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Container(
                    //   height: 30,
                    //   width: 30,
                    //   // color: Colors.blue,
                    //   child: SvgPicture.asset(AppImages.shareIcon),
                    // ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    GestureDetector(
                      onTap: onTapFavorite,
                      child: SizedBox(
                        // height: 23,
                        // width: 23,
                        // color: Colors.amber,
                        // height: Get.height * 0.03,
                        // width: Get.width * 0.06,
                        // color: Colors.blue,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: AppColors.orange,
                          size: Get.width * 0.07,
                        ),
                        // child: SvgPicture.asset(
                        //   isFavorite ? AppImages.likeFull : AppImages.likeEmpty,
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  sectionNamePercentOfferes(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
      // width 0.78
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(
                // height: 32,
                // width: 32,

                height: heightNavBarCustom(context) * 0.05,
                width: Get.width * 0.1,

                child: ClipOval(
                  child: CachedNetworkImageCustom(image: shoppingModel.logo),
                ),
              ),
              SizedBox(
                // width: 10
                width: Get.width * 0.02,
              ),
              // width 0.66
              SizedBox(
                width: Get.width * 0.45,
                // color: Colors.amber,
                child: Text(
                  // 'أزياء ياسر  الدماس الدماس الدماس الدماس الدماس الدماس الدماس الدماس الدماسالدماس',
                  shoppingModel.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    // fontSize: 12,
                    fontSize: Get.width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Container(
                // height: 24,
                // width: 24,
                // color: Colors.blue,
                height: heightNavBarCustom(context) * 0.03,
                width: Get.width * 0.06,
                margin: EdgeInsets.only(bottom: 5),
                child: SvgPicture.asset(AppImages.fire),
              ),
              SizedBox(
                // color: Colors.red,
                width: Get.width * 0.12,
                child: Text(
                  // '40%',
                  // '10000%',
                  shoppingModel.discountCount + '%',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    // fontSize: 16,
                    fontSize: Get.width * 0.041,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
    // end Method
  }
}
