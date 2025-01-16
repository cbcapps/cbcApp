import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ui_ecommerce/AQS/controllers/Cart_controller.dart';
import 'package:ui_ecommerce/AQS/controllers/FirstController.dart';
import 'package:ui_ecommerce/AQS/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/AQS/controllers/Product_controller.dart';
import 'package:ui_ecommerce/AQS/views/Home.dart';
import 'package:ui_ecommerce/AQS/views/Landing.dart';
import 'package:ui_ecommerce/Togather/controllers/togatherController.dart';
import 'package:ui_ecommerce/Togather/views/landing.dart';
import 'package:ui_ecommerce/res/colors.dart';
import '../../main.dart';
class ProductPage extends StatelessWidget {
   ProductPage({super.key});
   final Product_controller controller = Get.put(Product_controller());
   final Cart_controller cart_controller = Get.put(Cart_controller());
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
        title: Text('155'.tr,
          style: TextStyle(
              fontSize: Get.height * 0.02,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        )
      ),
      body: RefreshIndicator(
        onRefresh: ()async {
          controller.fetchProduct();
        },
        child: SizedBox(
          height: Get.height,
          child: GetBuilder<Product_controller>(builder: (c){
            if(c.isLoadingItem.value){
              return loading_();
            }else{
              if(c.productList.isNotEmpty){
                return RefreshIndicator(
                  onRefresh: ()async{
                    controller.fetchProduct();
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Obx(() {
                        if(!controller.isLoadingItem.value){
                          return (controller.productList[0].images.length > 0)? sliders() : placholder404();
                        }else{
                          return placholderSlider();
                        }
                      }),
                      spaceH(Get.height * 0.01),
                      _text(c.productList[0].title , Get.height * 0.018,Colors.black,FontWeight.bold),
                      spaceH(Get.height * 0.03),
                      line(),
                      spaceH(Get.height * 0.01),
                      _brand(),
                      spaceH(Get.height * 0.01),
                      _description(c.productList[0].description),
                      spaceH(Get.height * 0.03),
                      line(),
                      spaceH(Get.height * 0.01),
                      price(),
                      spaceH(Get.height * 0.02),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child:  _payment(),
                      )
                    ],
                  ),
                );
              }else{
                return Center(child: Text('20'.tr),);
              }
            }
          },
          ),
        )
      )
    );
  }

   msgAdded(title , msg){
    return Get.snackbar(title, msg , colorText: AppColors.aqsfullGreen, backgroundColor: Colors.white);
  }
   loading_(){
     return Center(
       child: LoadingAnimationWidget.staggeredDotsWave(
         color: AppColors.aqsfullGreen,
         size: 80,
       ),);
   }
   loading_button(){
     return Center(
       child: LoadingAnimationWidget.staggeredDotsWave(
         color: Colors.black,
         size: 20,
       ),);
   }
   placholder404(){
     return Container(
       height: Get.height * 0.3,
       width: Get.width * 0.9,
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),
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
       width: Get.width * 0.9,
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),
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
   _payment(){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.02 , end: Get.width * 0.02),
    child: Row(
      children: [
        _counter(),
        spaceW(Get.width * 0.02),
        GetBuilder<Cart_controller>(builder: (builder){
          if(builder.isLoadingAdded.value){
            return loading_button();
          }else{
            return botton();
          }
        })
      ],
    ),
    );
   }

   botton(){
    return GetBuilder<Cart_controller>(builder: (builder){
      return Center(
        child: GestureDetector(
      onTap: (){
        builder.putDate(controller.productList[0].title, controller.productList[0].price, controller.count, controller.productList[0].id, controller.productList[0].image, controller.productList[0].category);
        if(!builder.isLoadingAdded.value){
          if(builder.isAddedCart.value){
            msgAdded('29'.tr, '30'.tr);
            togatherController c = Get.find();
            Landing_controller p = Get.find();
            c.setIndex(1);
            p.onItemTapped(2);
            p.setIndexMenu(1);
            Get.off(()=> Landing_togather());
          }else{
            msgAdded('32'.tr, '33'.tr);
          }
        }else{
          print(builder.msgAdded);
        }
      },
          child: Container(
            width: Get.width * 0.6,
            height: Get.width * 0.1,
            decoration: BoxDecoration(
                color: AppColors.aqsyallow,
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Center(
             child: Text('19'.tr,
             style: TextStyle(
             color: AppColors.aqsfullGreen,
             fontSize: Get.height * 0.013,
             fontWeight: FontWeight.bold
             )),
             ),
          ),
        ),
      );
    });
   }
   _brand(){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.02 , end: Get.width * 0.02),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(Get.height * 0.005),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(45))
          ),
          height: Get.height * 0.06,
          width: Get.height * 0.06,
          child: CachedNetworkImage(
            imageUrl: controller.productList[0].brandLogo ,
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
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${'156'.tr} : ${controller.productList[0].brand}'),
            Text('${'157'.tr} : ${controller.productList[0].model}'),
          ],
        )




      ],
    ),

    );
   }
  _counter(){
    return Center(
      child: GetBuilder<Product_controller>(builder: (c){
        return Container(
          width: Get.width * 0.3,
          height: Get.width * 0.1,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.aqsfullGreen,
              border: Border.all(color: AppColors.aqsfullGreen), // لون الإطار
              borderRadius: BorderRadius.circular(10.0), // تقريب زوايا الإطار
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min, // لجعل الصف يأخذ أقل مساحة ممكنة
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove , size: Get.width * 0.05,color: Colors.white,),
                    onPressed: controller.outCounter,
                  ),
                  GetBuilder<Product_controller>(builder: (builder){
                    return Text(
                      '${builder.count}', // عرض الكمية
                      style: TextStyle(
                          fontSize: Get.width * 0.04,
                          color: Colors.white
                      ),
                    );
                  }),
                  IconButton(
                    icon: Icon(Icons.add , size: Get.width * 0.05 , color: Colors.white),
                    onPressed: controller.inCounter, // زيادة الكمية
                  ),
                ],
              ),
            )
          ),

        );
      }),
    );
  }
   _description(String des){
     return Container(
       height: Get.width * 0.5,
       margin: EdgeInsetsDirectional.only(start: Get.height * 0.02 , end: Get.height * 0.05),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text('${'158'.tr} : ',
             textAlign: TextAlign.start,
             style: TextStyle(
               fontSize: Get.height * 0.014,
               fontWeight: FontWeight.bold,
               color : Colors.black,
             ),
           ),
           Expanded(
               child: ListView(
                 children: [
                   Text(des,
                     textAlign: TextAlign.start,
                     style: TextStyle(
                       fontSize: Get.height * 0.012,
                       fontWeight: FontWeight.w700,
                       color : Colors.black,
                     ),
                   ),
                 ],
               ))
         ],
       ),
     );
   }
   price(){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02),
     child: Row(
       children: [
         Image.asset('assets/images/icons/cash.png' , width: Get.width * 0.07, fit: BoxFit.contain,),
         spaceW(Get.height * 0.009),
         Text('165'.tr,
           style: TextStyle(
               fontSize: Get.height * 0.012,
               color: AppColors.aqsfullGreen,
               fontWeight: FontWeight.bold
           ),
         ),
         spaceW(Get.height * 0.009),
        Container(
          width: Get.width * 0.4,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.aqsfullGreen,
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Center(
            child:  GetBuilder<Product_controller>(builder: (builder){
              return Text(formatter.format(controller.productList[0].price) + ' '+ '18'.tr,
                style: TextStyle(
                    fontSize: Get.height * 0.013,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              );
            },),
          )
        ),
         spaceW(Get.height * 0.005),
         Center(
           child: Text("160".tr , style: TextStyle(
             color: AppColors.aqsfullGreen,
             fontWeight: FontWeight.bold,
             fontSize: Get.height * 0.013
         ),),),
       ],
     ),
     );
   }
   rate(double rate){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02),
    child: Row(
      children: [
        Text('(${controller.rate})'),
        spaceW(Get.height * 0.005),
        SizedBox(
          child: RatingBar.builder(
            initialRating: rate,
            minRating: 1,
            ignoreGestures: true,
            itemSize: 17,
            direction: Axis.horizontal,
            itemCount: 5,
            allowHalfRating: true,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              //controller.changeRate(rating);
            },
          ),
        )
      ],
    ),

    );
   }
   _text(String title , double size , Color color , FontWeight fontWeight){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02 , end: Get.width * 0.02),
     child: Text(title,
       textAlign: TextAlign.start,
       maxLines: 2,
       style: TextStyle(
           fontSize: size,
           fontWeight: fontWeight,
           color : color
       ),
     ),
     );
   }
  //builder.putDate(controller.productList[0].title, controller.productList[0].price, controller.productList[0].id, controller.productList[0].image, controller.productList[0].category, controller.productList[0].lastprice, controller.productList[0].rate);
   //
  line() {
    return Container(
      margin: EdgeInsets.only(right: Get.width * 0.05 , left: Get.width * 0.05),
      width: 200,
      height: Get.width * 0.003,
      color: AppColors.aqsyallow,
    );
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
  sliders() {
    return SizedBox(
      height:  Get.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true
              ,viewportFraction: 1.16,
              height: Get.height * 0.27,
              onPageChanged: (index, reason) {
                controller.changeindex(index);
              },
            ),
            items: controller.productList[0].images
                .map((item) => Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60)
                ),
                margin: EdgeInsets.all(Get.height * 0.002),
                padding: EdgeInsetsDirectional.only(start: Get.height * 0.02,end: Get.height * 0.02,bottom: Get.height * 0.004),
                child: ClipRRect(
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
          GetBuilder<Product_controller>(builder: (c){
            return DotsIndicator(
              dotsCount: controller.productList[0].images.length,
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
    );
  }
}
