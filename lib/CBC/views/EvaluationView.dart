import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:ui_ecommerce/CBC/controllers/AccountController.dart';
import 'package:ui_ecommerce/res/colors.dart';

import '../models/TestItem.dart';
class EvaluationView extends StatelessWidget {
  EvaluationView({super.key});
  final AccountController controller = Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        backgroundColor: AppColors.cbcColor,
        title: Text(
          'تقييم متجر',
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(child: notActive()),
      ),
    );
  }

  Widget notActive() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Get.width * 0.10,),
        SizedBox(
          child:  Image.asset('assets/images/icons/evaluation.png',
            width: Get.width * 0.5,
            height: Get.width * 0.3,
          ),
        ),
        SizedBox(
            child:  Text('قيم تجربتك للمتجر',
              style: TextStyle(
                  color: AppColors.cbcColor,
                  fontSize: Get.width * 0.04,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
        SizedBox(height: Get.width * 0.05,),
        searchTextInput(),
        //addressStore(),
        SizedBox(height: Get.width * 0.05,),

        // Add Star Rating here
        Text(
          'تقييم المتجر:',
          style: TextStyle(
            color: AppColors.cbcColor,
            fontSize: Get.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Get.width * 0.02,),
        RatingBar.builder(
          initialRating: 3,  // Default rating
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: AppColors.cbcColor,
          ),
          onRatingUpdate: (rating) {
            controller.rateStore(rating.toString());
            print(rating);
            print("User's rating: $rating"); // Handle rating update
          },
        ),
        SizedBox(height: Get.width * 0.05,),

        Padding(
          padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),

          child: GestureDetector(
            onTap: () {
              controller.uploadRate();
            },
            child: Container(
              height: Get.width * 0.1,
              width: Get.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.cbcColor,
              ),
              child: Center(
                child: Text('رفع التقييم',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.03
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Padding addressStore() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Get.height * 0.02,
        end: Get.height * 0.002,
        top: Get.height * 0.015,
      ),
      child: SizedBox(
        width: Get.width * 0.8,
        height: Get.height * 0.05,
        child: TextField(
          controller: controller.address,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'عنوان المتجر',
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

          ),
        ),
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
        width: Get.width * 0.8,
        height: Get.height * 0.05,
        child: GetBuilder<AccountController>(builder: (c) {
          return TextFieldSearch(
            label: 'My Label',
            controller: controller.myController,
            future: () {
              return controller.fetchData();
            },
            getSelectedValue: (value) {
              if(value != null){
                print(controller.myController.text);
              }
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'اسم المتجر',
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

            ),
          );


        },),
      ),
    );
  }

}
