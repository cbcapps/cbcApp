import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/Delivery_controller.dart';
class Delivery extends StatelessWidget {
   Delivery({super.key});
   final Delivery_controller controller = Get.put(Delivery_controller());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        message(),
        _space(Get.height * 0.012),
        //-----name------//
        _text("56" , Get.height * 0.015,Colors.black,FontWeight.w600),
        _space(Get.height * 0.012),
        _textme("56" , controller.name, false),
        _space(Get.height * 0.02),
        //-----phone------//
        _text("3" , Get.height * 0.015,Colors.black,FontWeight.w600),
        _space(Get.height * 0.012),
        _textme("3" , controller.phone, false),
        _space(Get.height * 0.02),
        //------city------//
        _text("57" , Get.height * 0.015,Colors.black,FontWeight.w600),
        _space(Get.height * 0.012),
        _select(),
        _space(Get.height * 0.02),
        //-----address------//
        _text("58" , Get.height * 0.015,Colors.black,FontWeight.w600),
        _space(Get.height * 0.012),
        _textme("58" , controller.address, false),
        _space(Get.height * 0.02),
        _text("166" , Get.height * 0.015,Colors.black,FontWeight.w600),
        _space(Get.height * 0.02),
        _textme("166" , controller.note, false),
        _space(Get.height * 0.02),

      ],
    );
  }
   message(){
     return Padding(
       padding: EdgeInsetsDirectional.only(start: Get.height * 0.01 , end: Get.height * 0.03 , bottom: Get.height * 0.01,),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [

           Text('62'.tr,
             textAlign: TextAlign.start,
             style: TextStyle(
                 fontSize: Get.height * 0.02,
                 fontWeight: FontWeight.w700
             ),

           ),
           spaceH(Get.height * 0.01),
           Text('63'.tr,
             textAlign: TextAlign.start,
             style: TextStyle(
                 fontSize: Get.height * 0.016,
                 fontWeight: FontWeight.w500
             ),

           ),
           spaceH(Get.height * 0.01),
           line(),
         ],
       ),
     );
   }
   line() {
     return const Divider(
       color: Colors.black12,
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
  _select(){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.015, end: Get.width * 0.015 ),
       child : GetBuilder<Delivery_controller>(builder: (builder){
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black , width: 0.3)
        ),
        width: Get.width * 0.9,
        height: Get.width * 0.12,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            isExpanded: true,
            hint: Text(
              '59'.tr,
              style: TextStyle(
                fontSize: Get.height * 0.014,
                color: Colors.grey,
              ),
            ),
            items: builder.gonvernorates
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style:  TextStyle(
                  fontSize: Get.height * 0.014,
                  fontWeight: FontWeight.w500
                ),
              ),
            ))
                .toList(),
            value: builder.selectedGovernorate,
            onChanged: (value) {
             builder.changeSelect(value);
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      );
    }));
  }
   _text(String title , double size , Color color , FontWeight fontWeight ){
     return Padding(
         padding: EdgeInsetsDirectional.only(start: Get.width * 0.015),
       child: Text(title.tr,
         textAlign: TextAlign.start,
         style: TextStyle(
             fontSize: size,
             fontWeight: fontWeight,
             color : color
         ),
       ),

     );
   }
   SizedBox _space(double size){
     return SizedBox(
       height: size,
     );
   }
  Padding _textme(String title , TextEditingController textEditingController , bool ispassword ){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.015, end: Get.width * 0.015 ),
      child: TextField(

        style: TextStyle(
          fontSize: Get.height * 0.014
        ),
        obscureText: ispassword,
        controller: textEditingController,
        decoration:   InputDecoration(
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 0.1),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 0.1),
          ),
          hintText: title.tr,
          hintStyle: TextStyle(
            color: Colors.grey
          )
        ),
      ),
    );
  }
}
