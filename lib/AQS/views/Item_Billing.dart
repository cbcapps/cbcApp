import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ui_ecommerce/AQS/controllers/ItemBilling_controller.dart';
import 'package:ui_ecommerce/main.dart';
class Item_Billing extends StatelessWidget {
   Item_Billing({super.key});
   final ItemBilling_controller controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation:0.0,
        surfaceTintColor: Colors.white,
        elevation: 0.0,
        leadingWidth: Get.height * 0.09,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: Get.height * 0.03 , top: Get.height * 0.02),
          child: GestureDetector(
            child: Text('53'.tr , style: TextStyle(
                fontSize: Get.height * 0.017,
                fontWeight: FontWeight.w500
            ),),
            onTap: () => Get.back(),
          ),
        ),
        centerTitle: true,
        title: Text('79'.tr , style: TextStyle(
            fontWeight: FontWeight.w600,
          fontSize: 19
        ),),
      ),
      body: Container(
        height: Get.height,
        child: Column(
          children: [
          GetBuilder<ItemBilling_controller>(builder: (builder){
            if(!builder.LoadingItem.value){
              if(builder.SalesList.isNotEmpty){
                int totalPrice = builder.SalesList[0].price + builder.SalesList[0].delivery;
                String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(builder.SalesList[0].date);
                return card(totalPrice, builder.SalesList[0].id, builder.SalesList[0].status, formattedDate,builder.SalesList[0].price,builder.SalesList[0].delivery);
              }else{
                  return Center(child: Text('20'.tr),);
              }
            }else{
              return loading_();
            }
          }),
            Expanded(
              child: Cartslist(),
            ),
            SizedBox(height: 10,),

          ],
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
  card(total , id , status , date,price,delivery){
    var status_code ;
    if(status == 0){
      status_code = "73";
    }else if(status == 1){
      status_code = "74";
    }else if(status == 2){
      status_code = "75";
    }
    return Card(
      // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // Set the clip behavior of the card
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // Define the child widgets of the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
          SizedBox(
            child: Image.asset(
              'assets/images/relaxed-male.jpg',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            height: Get.width / 1.8,
            width: Get.width,
          ),

          // Add a container with padding that contains the card's title, text, and buttons
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Display the card's title using a font size of 24 and a dark grey color
                Text(
                  '${formatter.format(total)} ${'18'.tr}',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600
                  ),
                ),
                // Add a space between the title and the text
                SizedBox(height: 10),
                // Display the card's text using a font size of 15 and a light grey color

                Row(
                  children: [
                    Text(
                      '${'47'.tr} : ${formatter.format(price)} ${'18'.tr}',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      '${'44'.tr} : ${formatter.format(delivery)} ${'18'.tr}',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                // Add a row with two buttons spaced apart and aligned to the right side of the card
                Row(
                  children: <Widget>[
                    Text((status_code.toString().tr) , textAlign: TextAlign.start,
                      style: TextStyle(
                        color:  (status == 0)? Colors.black : (status == 1)? Colors.deepPurple : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 10,),
                    (status == 0)? FaIcon(FontAwesomeIcons.hourglass , size: 15, color: Colors.black,) : (status == 1)? FaIcon(FontAwesomeIcons.truck , size: 15, color: Colors.deepPurple,)  : FaIcon(FontAwesomeIcons.check,size: 15 , color: Colors.green,) ,
                    // Add a spacer to push the buttons to the right side of the card
                    SizedBox(width: 15,),
                    Text(
                      '#${'71'.tr} ${id}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),


                    const Spacer(),
                    // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                    Text(
                      '${date}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),

                    // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text

                  ],
                ),

              ],
            ),
          ),
          // Add a small space between the card and the next widget
          Container(height: 10),
        ],
      ),
    );

  }
   Cartslist() {
     return GetBuilder<ItemBilling_controller>(builder: (builder) => ListView.builder(
       padding: EdgeInsets.only(right: Get.height * 0.009,left: Get.height * 0.009 , top: Get.height * 0.01),
       // to disable GridView's scrolling
       shrinkWrap: true, // You won't see infinite size error
       itemCount: builder.SalesList.length,
       itemBuilder: (BuildContext context, int index) {
         final item = builder.SalesList[index];
         return BestProductItem(item.title, item.priceItem, item.image, item.count);
       },
     )
     );
   }

   BestProductItem(String title , int price , String url , int count ){
     return Container(
       height: Get.height * 0.17,
       padding: EdgeInsets.all(Get.height * 0.017),
       margin: EdgeInsets.only(top: Get.height * 0.01),
       width: Get.height * 0.2,
       decoration: BoxDecoration(
           color: Colors.white,
           border: Border.all(color: Colors.black12),
           borderRadius: BorderRadius.all(Radius.circular(15))
       ),
       child: Stack(
         children: <Widget>[
           PositionedDirectional(
             top: Get.height * 0.003,
             start: Get.height * 0.0001,
             bottom: Get.height * 0.002,
             child: Container(
                 height: Get.height * 0.12,
                 width: Get.height * 0.14,
                 padding: EdgeInsets.all(2),
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
                   placeholder: (context, url) => CircularProgressIndicator(),
                   errorWidget: (context, url, error) => const Icon(Icons.error),
                 )),
           ),
           PositionedDirectional(
             top: Get.height * 0.01,
             start:  Get.height * 0.15,
             child: SizedBox(
               width: Get.height * 0.2,
               child: Text(title , textAlign: TextAlign.start,
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ),),
           PositionedDirectional(
             bottom: Get.height * 0.02,
             start:   Get.height * 0.15,
             child:  Text(formatter.format(price) + ' '+'18'.tr , textAlign: TextAlign.start,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(
                   fontWeight: FontWeight.w800,
                   color: Colors.deepPurple,
                   fontSize: Get.height * 0.014
               ),
             ),),
           PositionedDirectional(
             bottom: Get.height * 0.01,
             end:  Get.height * 0.015,
             child: Text(
               '(${count})',
               style: TextStyle(fontSize: Get.height * 0.02 , color: Colors.deepPurple),
             ),
             ),

         ],
       ),
     );
   }

}
