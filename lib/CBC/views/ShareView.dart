import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/colors.dart';
import '../controllers/Help.dart';

class ShareView extends StatelessWidget {
  ShareView({super.key});
  final HelpController controller = Get.put(HelpController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () async{
          controller.fetchQr();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Center(
              child: SizedBox(
                height: Get.width * 0.3,
                width: Get.width * 0.8,
                child: Image.asset('assets/images/callcenter.png', fit: BoxFit.fill),
              ),
            ),
            Container(
              height: Get.width * 0.0003,
              width: Get.width * 0.9,
              color: Colors.black,
            ),
            SizedBox(
              height: Get.width * 0.05,
            ),
            Center(
              child: Text(
                '140'.tr,
                style: TextStyle(
                  color: AppColors.cbcRed,
                  fontWeight: FontWeight.bold,
                  fontSize: Get.width * 0.039,
                ),
              ),
            ),
            SizedBox(
              height: Get.width * 0.05,
            ),
            Center(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: Get.width * 0.1, end: Get.width * 0.1),
                child: Text(
                  '141'.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.03,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.width * 0.1,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: Get.width * 0.05, end: Get.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Get.width * 0.35,
                    child: Text(
                      '142'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.03,
                      ),
                    ),
                  ),
                  if (controller.qrList != null && controller.qrList.isNotEmpty)
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      height: Get.height * 0.15,
                      width: Get.height * 0.15,
                      child: CachedNetworkImage(
                        imageUrl: controller.qrList[0].image ?? '',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    )
                  else
                    const Icon(Icons.error, size: 50, color: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
