import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Home_controller.dart';
import 'package:ui_ecommerce/CBC/controllers/StoreController.dart';
import 'package:ui_ecommerce/CBC/views/StorePage.dart';
import '../../Togather/views/landing.dart';
import '../../res/colors.dart';
class Stories extends StatelessWidget {
   Stories({super.key});
  final StoreController controller = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(padding: const EdgeInsetsDirectional.only(end: 20),
            child:  GetBuilder<Chome_controller>(builder: (builder){
              return GestureDetector(
                onTap: (){
                  builder.onItemTapped(0);
                  Get.off(()=> Landing_togather());
                },
                child: const Icon(Icons.home),
              );
            },),
          )
        ],
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: AppColors.cbcColor,
        centerTitle: true,
        title: Text('${controller.city_name} - ${controller.cate_name}' ,style: TextStyle(
            color: Colors.white,
            fontSize: Get.width * 0.04,
            fontWeight: FontWeight.bold
        ),),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          print('refresh');
          controller.fetchStories(1);
        },
        child: GetBuilder<StoreController>(builder: (builder){
          if(!builder.isLoadingStories.value){
            if(builder.storiesList.isNotEmpty){
              return Container(
                  height: Get.height,
                  width: Get.width,
                  margin: EdgeInsets.only(bottom: Get.height * 0.02),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Obx(() {
                        if(!controller.isLoadingStories.value){
                          return (controller.storiesList[0].ads.length > 0)? StoreSliders() : placholder404();
                        }else{
                          return placholderSlider();
                        }
                      }),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: Get.width * 0.05 , right: Get.width * 0.05 ),
                          height: Get.width * 0.13,
                          width: Get.width ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Text('94'.tr ,
                                  style: TextStyle(
                                      color: AppColors.cbcColor,
                                      fontSize: Get.width * 0.05,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                              GetBuilder<StoreController>(builder: (builder){
                                return Container(
                                  height: Get.width * 0.07,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.cbcColor, // You can set the color of the border here
                                      width: 0.5, // You can adjust the width of the border here
                                    ),
                                    borderRadius: BorderRadius.circular(8.0), // Adjust the radius to round the corners of the border
                                  ),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      iconStyleData: IconStyleData(
                                          icon: Icon(Icons.filter_alt_rounded)
                                      ),

                                      isExpanded: true,
                                      hint: Center(
                                        child: Text(
                                          '76'.tr,
                                          style: TextStyle(
                                            fontSize: Get.width * 0.03,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                      ),
                                      items: builder.items
                                          .map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Center(
                                          child: Text(
                                            item,
                                            style:  TextStyle(
                                                fontSize: Get.width * 0.03,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                      value: builder.selectedValue,
                                      onChanged: (String? value) {
                                        builder.changeFilter(value);
                                      },
                                      buttonStyleData:  ButtonStyleData(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        height: Get.width * 0.3,
                                        width: Get.width * 0.25,
                                      ),
                                      menuItemStyleData:  MenuItemStyleData(
                                        height: Get.width * 0.08,

                                      ),
                                    ),
                                  ),
                                );
                              }

                              )
                            ],
                          ),
                        ),
                      ),

                      Obx(() {
                        if(!controller.isFilter.value){
                          return  Expanded(child: stories());
                        }else{
                          if(controller.isLoadingFilter.value){
                            return  Center(child: SpinKitWave(
                              color: AppColors.cbcColor,
                              size: Get.width * 0.1,
                            ),);
                          }else{
                            return  Expanded(child: stories());
                          }
                        }
                      }),

                    ],
                  )
              );
            }else{
              print('not data');
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
        }),
      ),
    );
  }
  filterRecently(){
    return Container(
      height: Get.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Padding(padding: EdgeInsets.only(top: Get.width * 0.04 , bottom: Get.width * 0.04),
         child:  Text('143'.tr , style: TextStyle(
           fontWeight: FontWeight.bold,
           fontSize: Get.width * 0.04
         ),),
         ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                    width: Get.width * 0.3,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Center(
                      child: Text('145'.tr ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03
                        ),
                      ),
                    )
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                child: Container(
                    width: Get.width * 0.3,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Center(
                      child: Text('146'.tr ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
          SizedBox(height: Get.width * 0.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: Get.width * 0.3,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Center(
                    child: Text('77'.tr ,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.03
                      ),
                    ),
                  )
                ),
              ),
              SizedBox(width: 10), // مسافة بين الزرين
              GestureDetector(
                child: Container(
                    width: Get.width * 0.3,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Center(
                      child: Text('78'.tr ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.03
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
          SizedBox(height: Get.width * 0.05),
          Container(
            height: 1,
            width: Get.width * 0.8,
            color: Colors.grey,
          ),
          SizedBox(height: Get.width * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                    width: Get.width * 0.25,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.cbcColor,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Center(
                      child: Text('147'.tr ,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03
                        ),
                      ),
                    )
                ),
              ),
              SizedBox(width: 10), // مسافة بين الزرين
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                    width: Get.width * 0.2,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Center(
                      child: Text('53'.tr ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.03
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
   placholderSlider(){
     return Container(
       height: Get.height * 0.3,
       width: Get.width * 0.97,
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),
           border: Border.all(color: Colors.white60)
       ),
       margin: EdgeInsets.all(Get.height * 0.004),
       child: Center(
           child: ClipRRect(
             borderRadius: BorderRadius.circular(10.0),
             child: const CircularProgressIndicator(),
           )
       ),
     );
   }
   placholder404(){
     return Container(
       height: Get.height * 0.3,
       width: Get.width * 0.97,
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),
           border: Border.all(color: Colors.white60)
       ),
       margin: EdgeInsets.all(Get.height * 0.004),
       child: Center(
           child: ClipRRect(
             borderRadius: BorderRadius.circular(10.0),
             child: Image.asset('assets/images/comingsoon.jpg' , fit: BoxFit.fill,),
           )
       ),
     );
   }
   StoreSliders(){
     return Padding(padding: EdgeInsetsDirectional.only(top: Get.height * 0.02 ),
       child: SizedBox(
         height:  Get.height * 0.2,
         child: Column(
           children: [
             CarouselSlider(
               options: CarouselOptions(
                 autoPlay: true
                 ,viewportFraction: 1,
                 height: Get.height * 0.18,
                 onPageChanged: (index, reason) {
                   controller.storiesList[0].ads;
                 },
               ),
               items: controller.storiesList[0].ads
                   .map((item) => Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30),
                       border: Border.all(color: Colors.white60)
                   ),
                   margin: EdgeInsets.all(Get.height * 0.002),
                   padding: EdgeInsetsDirectional.only(start: Get.height * 0.02,end: Get.height * 0.02,top: Get.height * 0.004,bottom: Get.height * 0.004),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(10.0),
                     child: CachedNetworkImage(
                       imageUrl: item,
                       imageBuilder: (context, imageProvider) => Container(
                         decoration: BoxDecoration(
                           image: DecorationImage(
                             image: imageProvider,
                             fit: BoxFit.fill,
                           ),
                         ),
                       ),
                       placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                       errorWidget: (context, url, error) => const Icon(Icons.error),
                     ),
                   )
               ))
                   .toList(),
             ),
           ],
         ),
       ),
     );
   }









   stories(){
     return GridView.builder(
       padding: EdgeInsets.only(left: Get.height * 0.01, right: Get.height * 0.01, top: Get.height * 0.01 ),
       shrinkWrap: true,
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         crossAxisSpacing: 5.0,
         mainAxisSpacing: 5.0,
         childAspectRatio: 0.8,
       ),
       itemCount: controller.storiesList[0].stories.length,
       itemBuilder: (BuildContext context, int index) {
         final Item = controller.storiesList[0].stories[index];
         return StoreItem(Item.logo, Item.name, Item.id, Item.active , Item.discountCount);
       },
     );
   }
   StoreItem(String url , String title , int id , int active , String count) {
     if (id != -1) { // تحقق من أن الـ ID ليس يساوي -1 قبل عرض المحافظة
       return GestureDetector(
         onTap: () {
           Get.to(()=>StorePage() , arguments: [{"id" : id}]);


         },
         child: Container(
           margin: const EdgeInsets.all(8),
           padding: EdgeInsets.all(Get.height * 0.01),
           width: Get.height * 0.25,
           decoration: BoxDecoration(
               color: (active == 0) ? AppColors.cbcColor : Colors.white,
               border: Border.all(color: Colors.black12),
               borderRadius: const BorderRadius.all(Radius.circular(15))
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               (active == 1) ? Center(
                 child:  CachedNetworkImage(
                   height: Get.height * 0.15,
                   width: Get.height * 0.2,
                   imageUrl: url,
                   imageBuilder: (context, imageProvider) => Container(
                     decoration: BoxDecoration(
                       shape: BoxShape.circle, // جعل الصورة دائرية
                       image: DecorationImage(
                         image: imageProvider,
                         fit: BoxFit.cover, // استخدام BoxFit.cover لتغطية الصورة بالكامل
                       ),
                     ),
                   ),
                   placeholder: (context, url) => const CircularProgressIndicator(),
                   errorWidget: (context, url, error) => const Icon(Icons.error),
                 ),

               ) : const SizedBox(),
               SizedBox(height: Get.height * 0.01,),
               Center(
                 child: Text(title , textAlign: TextAlign.center,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                       fontSize: Get.width * 0.04,
                       fontWeight: FontWeight.bold,
                       color: AppColors.cbcColor

                   ),
                 ),
               ),
               SizedBox(height: Get.height * 0.007,),
              Center(
                child:  Text('${'95'.tr} ${count}' , textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w800,
                      color: AppColors.cbcRed
                  ),
                ),
              )
             ],
           ),
         ),
       );
     } else {
       return const SizedBox.shrink(); // إذا كان الـ ID يساوي -1، لا تعرض أي شيء باستخدام SizedBox.shrink()
     }
   }


}
