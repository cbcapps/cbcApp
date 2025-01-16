import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:ui_ecommerce/CBC/controllers/StorePageController.dart';
import 'package:ui_ecommerce/res/colors.dart';
class StorePage extends StatelessWidget {
   StorePage({super.key});
   final StorePageController controller = Get.put(StorePageController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: AppColors.cbcColor,
        title: Text(
            '96'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          print('refresh page ');
          controller.fetchStore();
        },
        child: GetBuilder<StorePageController>(builder: (builder){
          if(!builder.isLoadingItem.value){
            if(builder.store != null){
              return  Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Obx(() {
                      if(!builder.isLoadingItem.value){
                        return (builder.store!.storeinfo.sliders.length > 0)? StoreSliders() : placholder404();
                      }else{
                        return placholderSlider();
                      }
                    }),
                    StoreLogo(),
                    StoreInfo(),
                    TabsPages(),
                    SizedBox(
                      height: Get.width * 0.03,
                    ),
                    PagesTabs(),
                  ],
                ),
              );
            }else{
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('20'.tr),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    FaIcon(FontAwesomeIcons.faceSadTear)
                  ],
                ),
              );
            }
          }else{
            return Center(child: SpinKitWave(
              color: AppColors.cbcColor,
              size: Get.width * 0.1,
            ),);
          }
        },),
      ),
    );
  }
  TabsPages(){
    return Padding(padding: EdgeInsetsDirectional.only(top: Get.width * 0.05 , start: Get.width * 0.05 , end: Get.width * 0.05),
    child: Column(
      children: [
        TabBar(
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: false,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.cbcColor,
          ),
          indicatorWeight: 0.0, // تعيين الوزن إلى 0.0 لإزالة الخط
          labelStyle:  TextStyle(
              fontSize: Get.width * 0.021,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Tajawal'
          ),
          unselectedLabelStyle: TextStyle(
              fontSize: Get.width * 0.021,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Tajawal'
          ),
          controller: controller.tabController,
          tabs: [
            Tab(text: '98'.tr),
            Tab(text: '99'.tr),
            Tab(text: '100'.tr),
            Tab(text: '101'.tr),
          ],
        ),
      ],
    ),
    );
  }
   branches(){
     if(controller.store!.storeinfo.branches.isNotEmpty){
       return ListView.builder(

         padding: EdgeInsetsDirectional.only(start: Get.width * 0.02,end: Get.width * 0.02),
         itemCount: controller.store!.storeinfo.branches.length, // عدد العناصر في القائمة
         itemBuilder: (BuildContext context, int index) {
           return  ListTile(
             title: Container(
               decoration: BoxDecoration(
                 color: Colors.white, // لون خلفية الـ Container
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.withOpacity(0.5), // لون الظل مع شفافية
                     spreadRadius: 0, // إزالة انتشار الظل
                     blurRadius: 10, // زيادة تمويه الظل لجعله أكثر نعومة
                     offset: const Offset(0, 5), // الإزاحة فقط في الاتجاه العمودي
                   ),
                 ],
               ),
               child: Text(
                 controller.store!.storeinfo.branches[index].title,
                 style: TextStyle(
                     fontSize: Get.width * 0.028,
                     fontWeight: FontWeight.bold
                 ),
               ),
             ),
             trailing: Wrap(
               spacing: 12, // space between two icons
               children: <Widget>[
                GestureDetector(
                  onTap: (){
                    controller.callPhone(controller.store!.storeinfo.branches[index].phone);
                  },
                  child:  Container(
                    padding: EdgeInsets.all(Get.width * 0.01),
                    decoration: BoxDecoration(
                        color: AppColors.cbcColor,
                        border: Border.all(
                          color: AppColors.cbcColor,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    width: Get.width * 0.08,
                    height: Get.width * 0.06,
                    child: Center(
                      child: FaIcon(FontAwesomeIcons.phone , size: Get.width * 0.035, color: Colors.white,),
                    ),
                  ),
                ),
                 GestureDetector(
                   onTap: (){
                     controller.openurl(controller.store!.storeinfo.branches[index].location);
                   },
                   child: Container(
                     padding: EdgeInsets.all(Get.width * 0.01),
                     decoration: BoxDecoration(
                         color: AppColors.cbcColor,
                         border: Border.all(
                           color: AppColors.cbcColor,
                         ),
                         borderRadius: const BorderRadius.all(Radius.circular(10))
                     ),
                     width: Get.width * 0.08,
                     height: Get.width * 0.06,
                     child: Center(
                       child: FaIcon(FontAwesomeIcons.locationDot , size: Get.width * 0.035, color: Colors.white,),
                     ),
                   ),
                 )
               ],
             ),
           );

         },
       );
     }else{
       return Center(child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text('103'.tr),
           SizedBox(width: Get.width * 0.02,),
           const FaIcon(FontAwesomeIcons.faceSadTear)
         ],
       ),);
     }
   }
   imagesStore(list,text) {
     int desiredItemCount = 12; // العدد المطلوب للصور
     int actualItemCount = list.length;
     int placeholdersCount = desiredItemCount - actualItemCount;
     List<Widget> placeholders = List.generate(
       placeholdersCount,
           (index) => Container(
         margin: const EdgeInsets.all(2),
         decoration: const BoxDecoration(
           color: AppColors.cbcColor, // استخدم اللون المطلوب هنا
         ),
       ),
     );
    if(list.isNotEmpty){
      return GridView.builder(
        padding: EdgeInsets.only(left: Get.width * 0.05 ,right: Get.width * 0.05),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: desiredItemCount, // استخدم العدد المطلوب للصور
        itemBuilder: (BuildContext context, int index) {
          if (index < actualItemCount) {
            // إذا كان العنصر صورة حقيقية
            return GestureDetector(
              onTap: () {
                Get.dialog(
                  Dialog(
                    insetPadding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        ClipRect( // Wrap PhotoView with ClipRect
                          child: SizedBox(
                            width: Get.width ,
                            height: Get.height * 0.5,
                            child: PhotoView(
                              imageProvider: CachedNetworkImageProvider(
                                list[index],
                              ),
                              backgroundDecoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              initialScale: PhotoViewComputedScale.contained
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  barrierDismissible: true,
                );

              },
              child: Container(
                margin: const EdgeInsets.all(2),
                child: CachedNetworkImage(
                  imageUrl: list[index],
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
            );
          } else {
            // إذا كان العنصر placeholder
            return placeholders[index - actualItemCount];
          }
        },
      );
    }else{
      return Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text),
          SizedBox(width: Get.width * 0.02,),
          const FaIcon(FontAwesomeIcons.faceSadTear)
        ],
      ),);
    }
   }
  discounts(){
    if(controller.store!.storeinfo.discounts.isNotEmpty){
      return  ListView.builder(
        padding: EdgeInsetsDirectional.only(start: Get.width * 0.02,end: Get.width * 0.02),
        itemCount: controller.store!.storeinfo.discounts.length, // عدد العناصر في القائمة
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Container(
              decoration: BoxDecoration(
                color: Colors.white, // لون خلفية الـ Container
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // لون الظل مع شفافية
                    spreadRadius: 0, // إزالة انتشار الظل
                    blurRadius: 10, // زيادة تمويه الظل لجعله أكثر نعومة
                    offset: const Offset(0, 5), // الإزاحة فقط في الاتجاه العمودي
                  ),
                ],
              ),
              child: Text(
                controller.store!.storeinfo.discounts[index].title,
                style: TextStyle(
                    fontSize: Get.width * 0.033
                ),
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.all(Get.width * 0.01),
              decoration: BoxDecoration(
                  color: AppColors.cbcRed,
                  border: Border.all(
                    color: AppColors.cbcRed,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              width: Get.width * 0.20,
              height: Get.width * 0.06,
              child: Center(
                child: Text('${controller.store!.storeinfo.discounts[index].discount}' , style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.03
                ),),
              ),
            ),
          );
        },
      );
    }else{
      return Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('102'.tr),
          SizedBox(width: Get.width * 0.02,),
          const FaIcon(FontAwesomeIcons.faceSadTear)
        ],
      ),);
    }
  }
   PagesTabs(){
    return Expanded(
      child: TabBarView(
        controller: controller.tabController,
        children: [
          discounts(),
          branches(),
          imagesStore(controller.store!.storeinfo.images,'104'.tr),
          imagesStore(controller.store!.storeinfo.offers,'105'.tr),
        ],
      ),
    );
  }

  StoreLogo(){
    return  Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.05),
    child: Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          height: Get.height * 0.08,
          width: Get.height * 0.08,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45.0),
            child: CachedNetworkImage(
              imageUrl: controller.store!.storeinfo.logo ,
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
        SizedBox(
          width: Get.width * 0.04,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * 0.63,
              child: Text(controller.store!.storeinfo.name ,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:  TextStyle(
                  fontSize: Get.width * 0.03,
                  fontWeight: FontWeight.bold,
                ),),
            ),
            SizedBox(
              width: Get.width * 0.63,
              child: Text(controller.store!.storeinfo.nameKur ,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:  TextStyle(
                  fontSize: Get.width * 0.03,
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ],
        )

      ],
    ),
    );
  }
  StoreInfo(){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.05 , end: Get.width * 0.05 , top: Get.width * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       SizedBox(
         width: Get.width * 0.5,
         child:  Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('97'.tr,style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.bold,
               fontSize: Get.width * 0.03
             ),),
             SizedBox(
               height: Get.width * 0.02,
             ),
            SizedBox(
              height: Get.width * 0.2,
              child:  ListView(
                children: [
                  Text(controller.store!.storeinfo.description,style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: Get.width * 0.025
                  ),)
                ],
              ),
            ),

           ],
         ),
       ),
        SizedBox(
          width: Get.width * 0.3,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Container(
               padding: EdgeInsets.all(Get.width * 0.01),
               decoration: BoxDecoration(
                 color: AppColors.cbcRed,
                   border: Border.all(
                     color: AppColors.cbcRed,
                   ),
                   borderRadius: const BorderRadius.all(Radius.circular(20))
               ),
               width: Get.width * 0.35,
               height: Get.width * 0.12,
               child: Center(
                 child: Text(
                   '${controller.store!.storeinfo.categoryName}',
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   style:  TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: Get.width * 0.024
                   ),
                 ),
               ),
             ),
              SizedBox(
                height: Get.width * 0.02,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     GestureDetector(
                       onTap: (){
                         controller.openurl(controller.store!.storeinfo.instagram);
                       },
                       child:  Container(
                         padding: EdgeInsets.all(Get.width * 0.01),
                         decoration: BoxDecoration(
                             color: AppColors.cbcColor,
                             border: Border.all(
                               color: AppColors.cbcColor,
                             ),
                             borderRadius: const BorderRadius.all(Radius.circular(10))
                         ),
                         width: Get.width * 0.145,
                         height: Get.width * 0.06,
                         child: Center(
                           child: FaIcon(FontAwesomeIcons.instagram , size: Get.width * 0.035, color: Colors.white,),
                         ),
                       ),
                     ),
                      GestureDetector(
                        onTap: (){
                          controller.openurl(controller.store!.storeinfo.facebook);
                        },
                        child: Container(
                          padding: EdgeInsets.all(Get.width * 0.01),
                          decoration: BoxDecoration(
                              color: AppColors.cbcColor,
                              border: Border.all(
                                color: AppColors.cbcColor,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                          ),
                          width: Get.width * 0.145,
                          height: Get.width * 0.06,
                          child: Center(
                            child: FaIcon(FontAwesomeIcons.facebookF , size: Get.width * 0.035, color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.width * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  GestureDetector(
                    onTap: (){
                      controller.launchWhatsAppUri(controller.store!.storeinfo.whatsapp);
                    },
                    child:Container(
                      padding: EdgeInsets.all(Get.width * 0.01),
                      decoration: BoxDecoration(
                          color: AppColors.cbcColor,
                          border: Border.all(
                            color: AppColors.cbcColor,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      width: Get.width * 0.145,
                      height: Get.width * 0.06,
                      child: Center(
                        child: FaIcon(FontAwesomeIcons.whatsapp , size: Get.width * 0.035, color: Colors.white,),
                      ),
                    ),
                  ),
                      GestureDetector(
                        onTap: (){
                          controller.openurl(controller.store!.storeinfo.telegram);
                        },
                        child: Container(
                          padding: EdgeInsets.all(Get.width * 0.01),
                          decoration: BoxDecoration(
                              color: AppColors.cbcColor,
                              border: Border.all(
                                color: AppColors.cbcColor,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                          ),
                          width: Get.width * 0.145,
                          height: Get.width * 0.06,
                          child: Center(
                            child: FaIcon(FontAwesomeIcons.tiktok , size: Get.width * 0.035, color: Colors.white,),
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ],
          ),
        )
      ],
    ),
    );
  }
  StoreSliders(){
    return Padding(padding: EdgeInsetsDirectional.only(top: Get.height * 0.002 ),
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
                  controller.store!.storeinfo.sliders;
                },
              ),
              items: controller.store!.storeinfo.sliders
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
            GetBuilder<StorePageController>(builder: (c){
              return DotsIndicator(
                dotsCount: controller.store!.storeinfo.sliders.length,
                position: c.indexSlider,
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
}
