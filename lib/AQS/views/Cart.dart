import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/Cart_controller.dart';
import 'package:ui_ecommerce/res/colors.dart';
import '../../main.dart';
import '../controllers/FirstController.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final Cart_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: GetBuilder<Cart_controller>(builder: (builder){
        if(BoxCart.isNotEmpty){
          return Container(
            height:  Get.height * 0.175,
            width: Get.width,
            color: Colors.white,
            padding: EdgeInsets.all(Get.height * 0.023),
            child: Column(
              children: [
                line(),
               spaceH(Get.width * 0.03),
                GetBuilder<Cart_controller>(builder: (builder){
                  return Container(
                    height: Get.height * 0.03,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white , width: 0.1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child:   Text('47'.tr,
                            style: TextStyle(
                                fontSize: Get.height * 0.014,
                                color: AppColors.aqsfullGreen,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          width: Get.width * 0.4,
                          height: Get.width * 0.06,
                          decoration: BoxDecoration(
                              color: AppColors.aqsfullGreen,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Center(
                            child: Text('${formatter.format(builder.total)} ${'160'.tr}', style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.height * 0.013,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        )
                      ],
                    ),
                  );
                }),
                GetBuilder<Cart_controller>(builder: (builder){
                  return  GestureDetector(
                    onTap: (){
                      if(BoxCart.isNotEmpty){
                        FirstController firstController = Get.put(FirstController());
                        (sharedPreferences.getBool('remember') == true) ?
                        Get.toNamed('checkout' , arguments: [{'total' : builder.total}])
                        : firstController.onItemTapped(1);
                      }
                    },
                    child: Container(
                      height: Get.height * 0.04,
                      width: Get.height * 0.38,
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          color: AppColors.aqsyallow,
                          border: Border.all(color: Colors.deepPurple , width: 0.1)
                      ),
                      child: Center(
                        child: Text('31'.tr, style: TextStyle(
                            color: AppColors.aqsfullGreen,
                            fontSize: Get.height * 0.015,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        }else{
          return const SizedBox();
        }
      },),
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: Get.height,
        child: GetBuilder<Cart_controller>(builder: (builder){
          if(BoxCart.isNotEmpty){
            return Cartslist();
          }else{
            return Center(child: Text('20'.tr),);
          }
        },),
      ),
    );
  }
  line() {
    return Container(
      margin: EdgeInsets.only(right: Get.width * 0.03 , left: Get.width * 0.03),
      width: Get.width,
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
  BestProductItem(String title , int price , String url , int id , int count , int category  , int index){
    return Container(
      height: Get.height * 0.2,
      padding: EdgeInsets.all(Get.height * 0.017),
      margin: EdgeInsets.only(top: Get.height * 0.01),
      width: Get.height * 0.2,
      decoration: BoxDecoration(
        color:  AppColors.aqsfullGreen,
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.all(Radius.circular(15))
      ),
      child: Stack(
        children: <Widget>[
          PositionedDirectional(
           bottom: Get.height * 0.007,
           start:  Get.height * 0.15,
           child:  GetBuilder<Cart_controller>(builder: (builder){
             return GestureDetector(
               child:const Icon(Icons.delete_outline_rounded , color: AppColors.aqsyallow,),
               onTap: (){
                 builder.deleteData(index);
               },

             );
           },),),
          PositionedDirectional(
            top: Get.height * 0.003,
            start: Get.height * 0.0001,
            bottom: Get.height * 0.002,
            child: Container(
                height: Get.height * 0.12,
                width: Get.height * 0.14,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  )),
              child: CachedNetworkImage(
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
              )),
          ),
          PositionedDirectional(
            top: Get.height * 0.01,
            start:  Get.height * 0.15,
            child: SizedBox(
              width: Get.height * 0.2,
              child: Text(title , textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),),
          PositionedDirectional(
            bottom: Get.height * 0.045,
            start:   Get.height * 0.15,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/icons/total.png' , width: Get.width * 0.08, height: Get.width * 0.13, fit: BoxFit.cover,),
                spaceW(Get.height * 0.002),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child:   Text('165'.tr,
                    style: TextStyle(
                        fontSize: Get.height * 0.012,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                spaceW(Get.height * 0.005),
                Padding(padding: EdgeInsets.only(top: 4),
                  child:  Text(formatter.format(price) , textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.aqsyallow,
                        fontSize: Get.height * 0.012
                    ),
                  ),),
                spaceW(Get.height * 0.005),
                Padding(padding: EdgeInsets.only(top: 3),
                  child: Center(
                    child: Text("160".tr , style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * 0.01
                    ),),),
                ),
              ],
            ),),
          PositionedDirectional(
            bottom: Get.height * 0.005,
            end:  Get.height * 0.015,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: GetBuilder<Cart_controller>(builder: (builder){
                        return Row(
                          mainAxisSize: MainAxisSize.min, // لجعل الصف يأخذ أقل مساحة ممكنة
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                width: Get.height * 0.04,
                                height: Get.height * 0.035,
                                decoration: BoxDecoration(
                                    color: AppColors.aqsyallow,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.aqsyallow,
                                      width: 1,
                                    )),
                                child: const Center(
                                  child: Icon(Icons.remove , color: AppColors.aqsfullGreen,),),
                              ),
                              onTap: () async{
                                builder.updateCounterMin(title, price, count, index, url, category);
                              },
                            ),
                            spaceW(Get.height * 0.01),
                            Text(
                              '${count}',
                              style: TextStyle(fontSize: Get.height * 0.02 , color: Colors.white),
                            ),
                            spaceW(Get.height * 0.01),
                            GestureDetector(
                              child: Container(
                                width: Get.height * 0.04,
                                height: Get.height * 0.035,
                                decoration: BoxDecoration(
                                    color: AppColors.aqsyallow,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.aqsyallow,
                                      width: 1,
                                    )),
                                child: const Center(
                                  child: Icon(Icons.add , color: AppColors.aqsfullGreen,),),
                              ),
                              onTap: () async{
                                 builder.updateCounterPlus(title, price, count, index, url, category);

                                },
                            )
                          ],
                        );
                      },),
                    ),
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }
  Cartslist() {
    return GetBuilder<Cart_controller>(builder: (builder) => ListView.builder(
        padding: EdgeInsets.only(right: Get.height * 0.009,left: Get.height * 0.009 , top: Get.height * 0.01),
        // to disable GridView's scrolling
        shrinkWrap: true, // You won't see infinite size error
        itemCount: BoxCart.length,
        itemBuilder: (BuildContext context, int index) {
          final product = BoxCart.getAt(index);
          return BestProductItem(product.title, product.price, product.image, product.item, product.count, product.category,index);
          },
      )
    );
  }
}
