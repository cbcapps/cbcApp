import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Home_controller.dart';
import 'package:ui_ecommerce/res/colors.dart';

class Cities_view extends StatelessWidget {
   Cities_view({super.key});
  final Chome_controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cbcColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            controller.onItemTapped(0);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text('92'.tr ,style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: Get.height * 0.02),
        color: Colors.white,
        child: citys(),
      ),
    );
  }
   citys(){
     return GridView.builder(
       padding: EdgeInsets.only(left: Get.height * 0.01, right: Get.height * 0.01, top: Get.height * 0.01 ),
       shrinkWrap: true,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 3,
         crossAxisSpacing: 5.0,
         mainAxisSpacing: 5.0,
         childAspectRatio: 1,
       ),
       itemCount: controller.citiesList.where((city) => city.id != -1).length,
       itemBuilder: (BuildContext context, int index) {
         final city = controller.citiesList.where((city) => city.id != -1).toList()[index];
         return CityItem(city.image, city.title, city.id, city.active);
       },
     );
   }
   CityItem(String url , String title , int id , int active) {
     if (id != -1) { // تحقق من أن الـ ID ليس يساوي -1 قبل عرض المحافظة
       return GestureDetector(
         onTap: () {
           Get.toNamed('categories_cbc' , arguments: [{'id': id , 'city' : title}]);

         },
         child: Container(
           padding: EdgeInsets.all(Get.height * 0.01),
           width: Get.height * 0.25,
           decoration: BoxDecoration(
               color: (active == 1) ? AppColors.cbcColor : Colors.blue,
               border: Border.all(color: Colors.black12),
               borderRadius: BorderRadius.all(Radius.circular(15))
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
                   placeholder: (context, url) => CircularProgressIndicator(),
                   errorWidget: (context, url, error) => const Icon(Icons.error),
                 ),
               ) : SizedBox(),
               SizedBox(height: Get.height * 0.01,),
               Center(
                 child: Text(title , textAlign: TextAlign.center,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: Colors.white
                   ),
                 ),
               )
             ],
           ),
         ),
       );
     } else {
       return SizedBox.shrink(); // إذا كان الـ ID يساوي -1، لا تعرض أي شيء باستخدام SizedBox.shrink()
     }
   }


}
