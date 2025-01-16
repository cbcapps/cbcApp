import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ui_ecommerce/AQS/controllers/Products_controller.dart';
import '../../main.dart';
import '../../res/colors.dart';
import '../controllers/Cart_controller.dart';
class Products extends StatelessWidget {
   Products({super.key});
   final Products_Controller controller = Get.put(Products_Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation:0.0,
          elevation: 0.0,
          backgroundColor: AppColors.aqsfullGreen,
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          title: Text('${controller.category} - ${controller.subCategory}' ,
            style: TextStyle(
                fontSize: Get.height * 0.02,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          )
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          controller.fetchProduct(controller.id);

        },
        child: GetBuilder<Products_Controller>(builder: (builder){
          if(!builder.isLoadingItem.value){
            if(builder.productList.isNotEmpty){
              return ItemsList();
            }else{
              return Center(child: Text('20'.tr),);
            }
          }else{
            return  loading_();
          }

        }
        ),
      ),
    );
  }
   loading_(){
     return Center(
       child: LoadingAnimationWidget.staggeredDotsWave(
         color: Colors.black,
         size: 80,
       ),);
   }
  SizedBox spaceH(double size) {
    return SizedBox(
      height: size,
    );
  }
  SizedBox spaceW(double size) {
    return SizedBox(
      width: size,
    );
  }
  ItemsList() {
    return GridView.builder(
      padding: EdgeInsets.only(right: Get.height * 0.009,left: Get.height * 0.009),
      // to disable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 0.95,
      ),
      itemCount: controller.productList.length,
      itemBuilder: (BuildContext context, int index) {
        final product = controller.productList[index];
        return BestProductItem(
          product.image,
          product.title,
          product.price,
          product.id,
          product.category
        );
      },
    );
  }
   BestProductItem(String url , String title , int price , int id , int category ){
     return GestureDetector(
       onTap: (){
         Get.toNamed('product' , arguments:[{"id": id}],);
       },
       child: Container(

         margin: EdgeInsets.all(Get.width * 0.02),
         width: Get.height * 0.15,
         decoration: BoxDecoration(
             color: AppColors.aqssubgreen,
             border: Border.all(color: Colors.black12),
             borderRadius: BorderRadius.all(Radius.circular(15))
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Container(
               color: Colors.white,
               margin: EdgeInsets.all(3),
               child: Center(
                 child:  CachedNetworkImage(
                   height: Get.height * 0.1,
                   width: Get.height * 0.5,
                   imageUrl: url,
                   imageBuilder: (context, imageProvider) => Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       border: Border.all(color: Colors.black12),
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                       image: DecorationImage(
                         image: imageProvider,
                         fit: BoxFit.contain,
                       ),
                     ),
                   ),
                   placeholder: (context, url) => CircularProgressIndicator(),
                   errorWidget: (context, url, error) => const Icon(Icons.error),
                 ),
               ),
             ),
             spaceH(Get.height * 0.01),
             Container(
               color: AppColors.aqssubgreen,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Center(
                     child:Text(title , textAlign: TextAlign.center,
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         color: AppColors.aqsfullGreen,
                         fontSize: Get.width * 0.025,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                   spaceH(Get.height * 0.004),
                   Container(
                     color: AppColors.aqsyallow,
                     height: Get.width * 0.004,
                     width: Get.width,
                   ),
                   spaceH(Get.height * 0.004),
                   Center(
                     child: Text(formatter.format(price).toString() + ' ' + '18'.tr , textAlign: TextAlign.start,
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                           fontSize: Get.height * 0.0135,
                           fontWeight: FontWeight.w600,
                           color: AppColors.aqsfullGreen
                       ),
                     ),
                   ),
                   GestureDetector(
                     onTap: (){
                       Cart_controller con = Get.find();
                       con.putDate(title, price, 1, id, url, category);
                       if(!con.isLoadingAdded.value){
                         if(con.isAddedCart.value){
                           msgAdded('29'.tr, '30'.tr);
                         }else{
                           msgAdded('32'.tr, '33'.tr);
                         }
                       }else{
                         print(con.msgAdded);
                       }
                     },
                     child: Container(
                         width: Get.width,
                         padding: EdgeInsets.all(5),
                         decoration: BoxDecoration(
                             color: AppColors.aqsyallow,
                             border: Border.all(color: Colors.black12),
                             borderRadius: BorderRadius.all(Radius.circular(10))
                         ),

                         child: Center(
                           child: Text(
                             '19'.tr,
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: Get.width * 0.025
                             ),
                           ),
                         )
                     ),
                   ),
                 ],
               ),
             )
           ],
         ),
       ),
     );
   }
   msgAdded(title , msg){
     return Get.snackbar(title, msg , colorText: AppColors.aqsfullGreen, backgroundColor: Colors.white);
   }
}
