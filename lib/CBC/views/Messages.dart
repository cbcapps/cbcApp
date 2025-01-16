import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/MessageController.dart';
import 'package:ui_ecommerce/res/colors.dart';

class MessagesView extends StatelessWidget {
  MessagesView({super.key});
  final MessageController controller = Get.put(MessageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.cbcColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          '151'.tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: Get.height * 0.02 , top: Get.height * 0.02),
        color: Colors.white,
        child: Obx(() {
          if (!controller.isLoadingItem.value) {
            if (controller.messagesList != null) {
              return RefreshIndicator(
             child: messages(),
              onRefresh: ()async{
               print('refresh');
               controller.fetchMessages();
              });
            } else {
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

  Widget messages() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.only(
        start: Get.width * 0.02,
        end: Get.width * 0.02,
      ),
      itemCount: controller.messagesList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: Get.width * 0.01 , left: Get.width * 0.02 , right: Get.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: Offset(0, 3), // Offset
                    ),
                  ],
                ),
                height: Get.width * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Center(
                     child:  Icon(Icons.notifications_outlined , color: Color(0xfff204391),),
                   ),
                    Container(
                      color: AppColors.cbcColor,
                      height: Get.width,
                      width: Get.width * 0.002,
                    ),
                   Padding(padding: EdgeInsets.all(Get.width * 0.03),
                     child:  Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           controller.messagesList[index].title ?? 'No title',
                           softWrap: true,
                           style: TextStyle(
                             fontSize: Get.height * 0.0125,
                             fontWeight: FontWeight.bold,
                             color: Colors.black,
                           ),
                         ),
                     SizedBox(
                       width: Get.width * 0.8,
                       child: Text(
                         controller.messagesList[index].body ?? 'No title',
                         softWrap: true,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                         style: TextStyle(
                           fontSize: Get.height * 0.0125,
                           fontWeight: FontWeight.bold,
                           color: Colors.grey,
                         ),
                       ),
                     ),
                       ],
                     ),


                   )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
