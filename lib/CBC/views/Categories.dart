import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/CategoriesController.dart';
import 'package:ui_ecommerce/CBC/controllers/Home_controller.dart';
import 'package:ui_ecommerce/CBC/views/Stories.dart';

import '../../Togather/views/landing.dart';
import '../../res/colors.dart';
class CategoriesView extends StatelessWidget {
   CategoriesView({super.key});
   final CategoriesController controller = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
         Padding(padding: EdgeInsetsDirectional.only(end: 20),
         child:  GetBuilder<Chome_controller>(builder: (builder){
           return GestureDetector(
             onTap: (){
               builder.onItemTapped(0);
               Get.off(()=>Landing_togather());
             },
             child: Icon(Icons.home),
           );
         },),
         )
        ],
        backgroundColor: AppColors.cbcColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text('${controller.city}' ,style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: ()async{
          controller.fetchRecently();
        },
        child: Container(
            height: Get.height,
            margin: EdgeInsets.only(bottom: Get.height * 0.02),
            color: Colors.white,
            child: GetBuilder<CategoriesController>(builder: (builder){
              if(!builder.isLoadingCategories.value){
                if(builder.categoriesList.isNotEmpty){
                  return Cats();
                }else{
                  return Center(
                    child: Text(
                        '${'20'.tr}'
                    ),
                  );
                }
              }else{
                return Center(child: SpinKitWave(
                  color: AppColors.cbcColor,
                  size: Get.width * 0.1,
                ),);
              }
            }
              ,)
        ),
      ),

    );
  }
   Cats(){
    return GridView.builder(
      padding: EdgeInsets.only(left: Get.height * 0.01, right: Get.height * 0.01, top: Get.height * 0.01 ),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 0.95,
      ),
      itemCount: controller.categoriesList.length,
      itemBuilder: (BuildContext context, int index) {
        final cate = controller.categoriesList[index];
        return CatItem(cate.image, cate.title, cate.id, cate.active);
      },
    );
  }
   CatItem(String url , String title , int id , int active) {
       return GestureDetector(
         onTap: () {
           Get.to(()=>Stories() , arguments: [{'cate' : id , 'city' : controller.id ,
             'id' : 0 ,'city_name' : controller.city ,  'cate_name' : title }]);
         },
         child: Container(
           height: Get.height,
           padding: EdgeInsets.all(Get.height * 0.01),
           width: Get.height * 0.25,
           decoration: BoxDecoration(
               color: (active == 0) ? AppColors.cbcRed : Colors.white,
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               (active == 1) ? Center(
                 child:  CachedNetworkImage(
                   height: Get.height * 0.08,
                   width: Get.height * 0.2,
                   imageUrl: url,
                   imageBuilder: (context, imageProvider) => Container(
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: imageProvider,
                         fit: BoxFit.contain,
                       ),
                     ),
                   ),
                   placeholder: (context, url) => const CircularProgressIndicator(),
                   errorWidget: (context, url, error) => const Icon(Icons.error),
                 ),
               ) : const SizedBox(),
               SizedBox(height: Get.height * 0.01,),
               Center(
                 child: Container(
                   width: Get.width,
                   child: Text(
                     title,
                     textAlign: TextAlign.center,
                     softWrap: true,
                     style: TextStyle(
                       fontSize: Get.width * 0.025,
                       fontWeight: FontWeight.bold,
                       color: Colors.black,
                     ),
                   ),
                 ),
               )
             ],
           ),
         ),
       );

   }
}
