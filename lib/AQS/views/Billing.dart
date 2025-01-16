import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_ecommerce/AQS/controllers/Billing_controller.dart';
import 'package:ui_ecommerce/main.dart';
class Billing extends StatelessWidget {
   Billing({super.key});
   final Billing_controller controller = Get.put(Billing_controller());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          spaceH(Get.height * 0.015),
          Row(
            children: [
              searchTextInput(),
              filtersIcon(),
            ],
          ),
          spaceH(Get.height * 0.015),
         Expanded(child:  BillList()),
          spaceH(Get.height * 0.015),
        ],
      )
    );
  }
   BillList() {
     return GetBuilder<Billing_controller>(builder: (builder) => ListView.builder(
       physics: PageScrollPhysics(),
       padding: EdgeInsets.only(right: Get.height * 0.009,left: Get.height * 0.009 , top: Get.height * 0.01),
       // to disable GridView's scrolling
       shrinkWrap: true, // You won't see infinite size error
       itemCount: builder.billsList.length,
       itemBuilder: (BuildContext context, int index) {
         final BillOne = builder.billsList[index];
         return BillItem(BillOne.price, BillOne.delivery, BillOne.city, BillOne.address, BillOne.date, BillOne.status,BillOne.phone , BillOne.id);
       },
     )
     );
   }
   BillItem(int price, int delivery, String city, String address, DateTime date, int status, String phone, int id) {
    var finalTotal = price + delivery;
    var status_code ;
    if(status == 0){
      status_code = "73";
    }else if(status == 1){
      status_code = "74";
    }else if(status == 2){
      status_code = "75";
    }
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(date);
     return GestureDetector(
       onTap: () {
         Get.toNamed('/Item_Billing', arguments: [{'id': id}]);
       },
       child: Container(
         height: Get.height * 0.19,
         padding: EdgeInsets.all(Get.height * 0.017),
         margin: EdgeInsets.only(top: Get.height * 0.01),
         width: Get.height * 0.2,
         decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(color: Colors.black12),
             borderRadius: BorderRadius.all(Radius.circular(15))
         ),
         child: Stack(
           children: [
             PositionedDirectional(
               top: Get.height * 0.01,
               end:  Get.height * 0.005,
               child: FaIcon(FontAwesomeIcons.moneyBill , color: Colors.green,),),
             PositionedDirectional(
               bottom: Get.height * 0.03,
               end:  Get.height * 0.005,
               child: SizedBox(
                 child: Text('${formattedDate}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ),),
             PositionedDirectional(
               bottom: Get.height * 0.001,
               end:  Get.height * 0.005,
               child: SizedBox(
                 child: Text(' #${id} ${'71'.tr}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),),
             PositionedDirectional(
               bottom: Get.height * 0.001,
               start:  Get.height * 0.005,
               child: SizedBox(
                 child: Row(
                   children: [
                     Text('${'72'.tr}' , textAlign: TextAlign.start,
                       style: TextStyle(
                         fontWeight: FontWeight.w600,
                         color: Colors.deepPurple
                       ),
                     ),
                     spaceW(Get.height * 0.01),
                     Icon(Icons.remove_red_eye_outlined , color: Colors.deepPurple,)
                   ],
                 ),
               ),),
             PositionedDirectional(
               bottom: Get.height * 0.033,
               start:  Get.height * 0.005,
               child: Row(
                 children: [
                   Text((status_code.toString().tr) , textAlign: TextAlign.start,
                     style: TextStyle(
                       color:  (status == 0)? Colors.black : (status == 1)? Colors.deepPurple : Colors.green,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   spaceW(10),
                   (status == 0)? FaIcon(FontAwesomeIcons.hourglass , size: 15, color: Colors.black,) : (status == 1)? FaIcon(FontAwesomeIcons.truck , size: 15, color: Colors.deepPurple,)  : FaIcon(FontAwesomeIcons.check,size: 15 , color: Colors.green,) ,
                 ],
               ),),
             PositionedDirectional(
               top: Get.height * 0.01,
               start:  Get.height * 0.005,
               child: SizedBox(
                 width: Get.height * 0.2,
                 child: Text('${'47'.tr} : ${formatter.format(price)} ${'18'.tr}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ),),
             PositionedDirectional(
               top: Get.height * 0.04,
               start:  Get.height * 0.005,
               child: SizedBox(
                 width: Get.height * 0.2,
                 child: Text('${'48'.tr} : ${formatter.format(delivery)} ${'18'.tr}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ),),
             PositionedDirectional(
               top: Get.height * 0.07,
               start:  Get.height * 0.005,
               child: SizedBox(
                 width: Get.height * 0.2,
                 child: Text('${'49'.tr} : ${formatter.format(finalTotal)} ${'18'.tr}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),),
           ],
         ),
       ),
     );
   }
  showDialog(){
    return Get.dialog(
        barrierDismissible: false,
        Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 10,bottom: 10),
                  child: Center(
                    child: Text("76".tr),
                  ),
                ),
                SizedBox(height:10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GetBuilder<Billing_controller>(builder: (c){
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            c.changeSelected(0);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent , width: 0.5),
                                color: (c.selectedIndex == 0)? Colors.deepPurple : Colors.white
                            ),
                            child: Text(
                              '77'.tr,
                              style: TextStyle(
                                  color: (c.selectedIndex == 0)? Colors.white : Colors.black
                              ),
                            ),
                          ),
                        ),
                        spaceW(5),
                        GestureDetector(
                          onTap: (){
                            c.changeSelected(1);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: (c.selectedIndex == 1)? Colors.deepPurple : Colors.white,
                                border: Border.all(color: Colors.blueAccent , width: 0.5)
                            ),
                            child: Text(
                              '78'.tr,
                              style: TextStyle(
                                  color: (c.selectedIndex == 1)? Colors.white : Colors.black
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },),
                ),
                Divider(
                  color: Colors.green,
                  thickness: 1,
                ),
                Padding(padding: EdgeInsets.all(10),
                  child:  Row(
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: Container(
                          child: Text(
                              '53'.tr
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
   Padding filtersIcon (){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.009 , end: Get.height * 0.009),
       child:  GestureDetector(
         onTap: showDialog,
         child: Icon(Icons.tune),
       ),
     );
   }
   Padding searchTextInput() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02 , end: Get.height * 0.002),
       child: SizedBox(
           width: Get.width * 0.83,
           child: TextField(
             decoration:  InputDecoration(
               fillColor: Colors.white,
               filled: true,
               prefixIcon: const Icon(Icons.search),
               hintText: '70'.tr,
               enabledBorder: const OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
                 borderSide:  BorderSide(
                   color: Colors.white,
                 ),
               ),
               focusedBorder: const OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
                 borderSide: BorderSide(color:Color(0xfff1ebf1),),
               ),
             ),
           )),
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
}
