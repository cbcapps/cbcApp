import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:ui_ecommerce/CBC/views/EvaluationView.dart';
import 'package:ui_ecommerce/CBC/views/FatoraView.dart';
import 'package:ui_ecommerce/CBC/views/Messages.dart';
import 'package:ui_ecommerce/CBC/views/SearchView.dart';
import 'package:ui_ecommerce/res/colors.dart';
import '../controllers/Home_controller.dart';
import '../models/TestItem.dart';
import 'package:badges/badges.dart' as badges;
import 'StorePage.dart';
class HomeView extends StatelessWidget {
   HomeView({super.key});
  final Chome_controller  controller = Get.put(Chome_controller());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: content(context),
      onRefresh: () async {
        controller.fetchCountMessages();
         controller.fetchRecently();
         controller.fetchHighest();
         controller.fetchCities();
         controller.fetchSliders();
      },
    );
  }
   Container content(context) {
     return Container(
       color: Colors.white,
       child: Column(
         children: [
           Row(
             children: [
               InkWell(
                 onTap: () {
                   _showGovernorateDialog(context); // عرض الحوار لاختيار المحافظة
                 },
                 child: Padding(
                   padding: EdgeInsetsDirectional.only(
                     start: Get.width * 0.03,
                     top: Get.width * 0.02,
                   ),
                   child: Icon(
                     Icons.filter_alt_rounded,
                     size: Get.width * 0.07,
                   ),
                 ),
               ),
               searchTextInput(), // إدخال النص للبحث
               Obx(() => GestureDetector(
                 onTap: () {
                   Get.to(() => MessagesView());
                 },
                 child: Padding(
                   padding: EdgeInsetsDirectional.only(
                     start: Get.height * 0.009,
                     end: Get.height * 0.009,
                     top: Get.height * 0.015,
                   ),
                   child: badges.Badge(
                     position: badges.BadgePosition.bottomEnd(bottom: 4, end: 15),
                     badgeAnimation: badges.BadgeAnimation.slide(),
                     showBadge: controller.showCartBadge.value,
                     badgeStyle: badges.BadgeStyle(
                       badgeColor: Colors.redAccent,
                     ),
                     badgeContent: Text(
                       controller.backgroundMessagesLength.value.toString(),
                       style: TextStyle(color: Colors.white),
                     ),
                     child: Icon(
                       Icons.notifications_outlined,
                       color: AppColors.cbcColor,
                       size: Get.height * 0.035,
                     ),
                   ),
                 ),
               )),
             ],
           ),
           SizedBox(
             height: Get.height * 0.02,
           ),
           // التعامل مع الـ Sliders
           Obx(() {
             if (!controller.isLoadingSliders.value) {
               return (controller.slidersList.isNotEmpty) ? sliders() : placholder404();
             } else {
               return placholderSlider();
             }
           }),
           Expanded(
             child: ListView(
               children: [
                 GetBuilder<Chome_controller>(builder: (builder) {
                   if (!builder.isLoadingCities.value) {
                     if (builder.citiesList.isNotEmpty) {
                       return citys();
                     } else {
                       return Center(
                         child: Text('${'20'.tr}'), // لا توجد محافظات
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
                 SizedBox(
                   height: Get.width * 0.2,
                   child: Center(
                     child: ListView(
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center, // Center items horizontally
                           children: [
                             InkWell(
                               onTap: () {
                                 Get.to(() => FatoraView());
                               },
                               child: SizedBox(
                                 height: Get.width * 0.1,
                                 width: Get.width * 0.5,
                                 child: Image.asset(
                                   'assets/images/icons/upload.png',
                                   fit: BoxFit.cover,
                                 ),
                               ),
                             ),
                             InkWell(
                               onTap: () {
                                 Get.to(() => EvaluationView());
                               },
                               child: SizedBox(
                                 width: Get.width * 0.5,
                                 height: Get.width * 0.1,
                                 child: Image.asset(
                                   'assets/images/icons/share.png',
                                   fit: BoxFit.cover,
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
                 SizedBox(
                   height: Get.height * 0.02,
                 ),
                 DiscountLabel('89'.tr, 'recentlyStories'),
                 SizedBox(
                   height: Get.height * 0.02,
                 ),
                 GetBuilder<Chome_controller>(builder: (builder) {
                   if (!builder.isLoadingRecently.value) {
                     if (builder.highestList.isNotEmpty) {
                       return discountItems(builder.recentlyList);
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
                 SizedBox(
                   height: Get.height * 0.02,
                 ),
                 DiscountLabel('91'.tr, 'HighestStories'),
                 SizedBox(
                   height: Get.height * 0.02,
                 ),
                 GetBuilder<Chome_controller>(
                   builder: (builder) {
                     if (!builder.isLoadingHighest.value) {
                       if (builder.highestList.isNotEmpty) {
                         return discountItems(builder.highestList);
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
                   },
                 ),
               ],
             ),
           ),
         ],
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
  discountItems(list) {
    return SizedBox(
      height: Get.height * 0.15,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: (list.length > 6) ? 6 : list.length,
        itemBuilder: (context, index) {
          var Item = list[index];
          return DiscountItem(Item.image, Item.store, Item.storeId , Item.discount);
        },
      ),
    );
  }
  DiscountItem(String url , String label  , int id , discount) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>StorePage() , arguments: [{"id" : id}]);
        //Get.toNamed('/products' , arguments: [{'id':id}]);
      },
      child: Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.01,end: Get.height * 0.01),
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              height: Get.height * 0.08,
              width: Get.height * 0.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45.0),
                child: CachedNetworkImage(
                  imageUrl: url,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.003,),
            SizedBox(
              width: Get.width * 0.24,
              child: Text(label,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Get.height * 0.011
                  )),),
            SizedBox(height: Get.height * 0.003,),
            Row(
              children: [
                const Text('الخصم ' ,  overflow: TextOverflow.ellipsis,),
                Text('${discount.toString()}',  overflow: TextOverflow.ellipsis,style: TextStyle(
                    color: AppColors.cbcRed,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.018
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
  DiscountLabel(title , page) {
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02 , end: Get.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: Get.height * 0.005,
                height: Get.height * 0.02,
                color: AppColors.cbcRed,
              ),
              SizedBox(
                width: Get.height * 0.01,
              ),
              Text(title , style: TextStyle(
                  fontSize: Get.height * 0.02,
                  fontWeight: FontWeight.bold
              ),)
            ],
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed('${page}');

            },
            child: Row(
              children: [
                Text("90".tr , style: TextStyle(
                    fontSize: Get.height * 0.016,
                    fontWeight: FontWeight.w600
                ),),
                SizedBox(width: Get.height * 0.007,),
                const Icon(Icons.arrow_circle_left_outlined , color: AppColors.cbcRed,),
              ],
            ),
          )
        ],
      ),
    );
  }



  Padding searchTextInput() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Get.height * 0.02,
        end: Get.height * 0.002,
        top: Get.height * 0.015,
      ),
      child: SizedBox(
        width: Get.width * 0.72,
        height: Get.height * 0.05,
        child: GetBuilder<Chome_controller>(builder: (c) {
          return TextFieldSearch(
            label: 'My Label',
            controller: controller.myController,
            future: () {
              return controller.fetchData();
            },
            getSelectedValue: (value) {
              if(value != null){
                TestItem selectedItem = value as TestItem; // تأكد من أن القيمة هي من نوع TestItem
                Get.to(()=>StorePage() , arguments: [{"id" : selectedItem.value}]);
                controller.myController.clear();
              }
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: '88'.tr,
              hintStyle: TextStyle(
                fontSize: Get.height * 0.015,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                borderSide: BorderSide(
                  color: AppColors.cbcColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                borderSide: BorderSide(color: AppColors.cbcColor,),
              ),
              suffixIcon: Container(
                decoration: const BoxDecoration(
                  color: AppColors.cbcColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                ),


                child: Icon(Icons.search, color: Colors.white, size: Get.height * 0.03),
              ),
            ),
          );




        },),
      ),
    );
  }

  sliders() {
    return Padding(padding: EdgeInsetsDirectional.only(top: Get.height * 0.002 , end: Get.height * 0.001 ),
      child: SizedBox(
        height:  Get.height * 0.22,
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true
                ,viewportFraction: 1,
                height: Get.height * 0.18,
                onPageChanged: (index, reason) {
                  controller.changeindex(index);
                },
              ),
              items: controller.slidersList
                  .map((item) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white60)
                  ),
                  margin: EdgeInsets.all(Get.height * 0.002),
                  padding: EdgeInsetsDirectional.only(start: Get.height * 0.004,end: Get.height * 0.004,top: Get.height * 0.004,bottom: Get.height * 0.004),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: item.image,
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
            GetBuilder<Chome_controller>(builder: (c){
              return DotsIndicator(
                dotsCount: controller.slidersList.length,
                position: c.index,
                decorator: DotsDecorator(
                  color: Colors.grey,
                  size: const Size.square(9.0),
                  activeSize:  Size(Get.height * 0.008, Get.height * 0.009,),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
  citys(){
    return GridView.builder(
      padding: EdgeInsets.only(left: Get.height * 0.04,right: Get.height * 0.04),
      physics: const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1.1,

      ),
      itemCount: (controller.citiesList.length > 8 )?  8 : controller.citiesList.length,
      itemBuilder: (BuildContext context, int index) {
        final city = controller.citiesList[index];
        return CityItem(
          city.image,
          city.title,
          city.id,
        );
      },
    );
  }
  CityItem(String url , String title , int id){
    if(id != -1){
      return  GestureDetector(
        onTap: (){
          Get.toNamed('categories_cbc' , arguments: [{'id': id , 'city' : title}]);
        },
        child: Container(
          padding: EdgeInsets.all(Get.height * 0.01),
          width: Get.height * 0.25,
          decoration: BoxDecoration(
              color: AppColors.cbcColor,
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.all(Radius.circular(15))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child:  CachedNetworkImage(
                  height: Get.height * 0.05,
                  imageUrl: url,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(height: Get.height * 0.005,),
              Center(
                child: Text(title , textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style:  TextStyle(
                    fontSize: Get.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }else {
      return  GestureDetector(
        onTap: (){
           controller.onItemTapped(1);
        },
        child: Container(
          padding: EdgeInsets.all(Get.height * 0.01),
          width: Get.height * 0.25,
          decoration: BoxDecoration(
              color: AppColors.cbcRed,
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.all(Radius.circular(15))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child:  CachedNetworkImage(
                  height: Get.height * 0.045,
                  width: Get.height * 0.055,
                  imageUrl: url,
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
              ),
              SizedBox(height: Get.height * 0.005,),
              Center(
                child: Text(title , textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style:  TextStyle(
                      fontSize: Get.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
   void _showGovernorateDialog(BuildContext context) {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return Obx(() {
           return AlertDialog(
             title: Text('اختيار المحافظة'),
             content: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 // عرض المحافظات في مربعات (3 محافظات في السطر)
                 Wrap(
                   spacing: 4.0, // المسافة بين المربعات
                   runSpacing: 8.0, // المسافة بين الأسطر
                   children: [
                     for (var city in controller.citiesList)
                       if (city.id != -1) // استثناء fixedItem
                         GestureDetector(
                           onTap: () {
                             // عند اختيار المحافظة، تحديث قيمة selectedGovernorate وعرض المناطق
                             controller.selectedGovernorate.value = city.title;
                             controller.fetchSubCity(city.title); // جلب المناطق
                           },
                           child: Container(
                             padding: EdgeInsets.all(6),
                             decoration: BoxDecoration(
                               color: controller.selectedGovernorate.value == city.title
                                   ? Colors.blueAccent // تغيير اللون عند الاختيار
                                   : Colors.grey[200],
                               borderRadius: BorderRadius.circular(8),
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.black26,
                                   blurRadius: 4,
                                   offset: Offset(2, 2),
                                 ),
                               ],
                             ),
                             width: (Get.width - 32) / 4, // عرض المربع (4 في السطر)
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   city.title,
                                   textAlign: TextAlign.center,
                                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                 ),
                               ],
                             ),
                           ),
                         ),
                   ],
                 ),

                 // عرض المناطق بناءً على اختيار المحافظة
                 if (controller.selectedGovernorate.isNotEmpty)
                   Padding(
                     padding: const EdgeInsets.only(top: 10),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('المناطق في ${controller.selectedGovernorate.value}:'),
                         // منطقة ثابتة للمناطق قابلة للتمرير
                         Container(
                           height: 200, // تحديد الارتفاع الثابت
                           child: SingleChildScrollView(
                             child: Wrap(
                               spacing: 4.0,
                               runSpacing: 8.0,
                               children: [
                                 for (var area in controller.selectedAreas)
                                   GestureDetector(
                                     onTap: () {
                                       // عند اختيار المنطقة، تحديث selectedArea
                                       controller.selectedArea.value = area; // تحديد المنطقة
                                     },
                                     child: Container(
                                       width: (Get.width - 32) / 4, // نفس عرض المربعات
                                       padding: EdgeInsets.all(6),
                                       decoration: BoxDecoration(
                                         color: controller.selectedArea.value == area
                                             ? Colors.green // تغيير اللون عند الاختيار
                                             : Colors.grey[200],
                                         borderRadius: BorderRadius.circular(8),
                                         boxShadow: [
                                           BoxShadow(
                                             color: Colors.black26,
                                             blurRadius: 4,
                                             offset: Offset(2, 2),
                                           ),
                                         ],
                                       ),
                                       child: Center(
                                         child: Text(
                                           area,
                                           textAlign: TextAlign.center,
                                           style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                         ),
                                       ),
                                     ),
                                   ),
                               ],
                             ),
                           ),
                         ),
                         // إظهار نص "تمرير لعرض المزيد" إذا كان هناك العديد من المناطق
                         if (controller.selectedAreas.length > 12) // يمكن تخصيص العدد الذي يظهر فيه النص
                           Padding(
                             padding: const EdgeInsets.only(top: 8),
                             child: Text(
                               'مرر للاسفل للمزيد...',
                               textAlign: TextAlign.center,
                               style: TextStyle(fontSize: 12, color: Colors.blue),
                             ),
                           ),
                       ],
                     ),
                   ),
               ],
             ),
             actions: [
               TextButton(
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
                 child: Text('إغلاق'),
               ),
               TextButton(
                 onPressed: () {
                   if (controller.selectedArea.value.isNotEmpty) {
                     print('تم تحديد المنطقة: ${controller.selectedArea.value}');
                     Get.to(() => Searchview(),
                       arguments: [
                         {
                           'subCity': controller.selectedArea.value,
                           'city': controller.selectedGovernorate.value,
                         } // إرسال id المنطقة
                       ],
                     );
                   } else {
                     print('لم يتم تحديد المنطقة');
                     // يمكنك أيضًا عرض رسالة للمستخدم أو تأكيد تحديد المنطقة
                     Get.snackbar(
                       "تنبيه",
                       "يرجى اختيار منطقة أولاً",
                       snackPosition: SnackPosition.BOTTOM,
                     );
                   }
                 },
                 child: Text(
                   'بحث',
                   style: TextStyle(
                     color: Colors.white, // تغيير لون النص إلى أبيض
                     fontWeight: FontWeight.bold, // جعل النص عريضًا
                     fontSize: 16, // تكبير حجم الخط
                   ),
                 ),
                 style: TextButton.styleFrom(
                   backgroundColor: AppColors.cbcColor, // تعيين لون الخلفية
                   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // إضافة بعض الحشو داخل الزر
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8), // تحديد حواف دائرية
                   ),
                   elevation: 4, // إضافة تأثير الظل
                 ),
               ),
             ],
           );
         });
       },
     );
   }





}
