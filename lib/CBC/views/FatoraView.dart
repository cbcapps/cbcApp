import 'dart:io';  // For handling files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:ui_ecommerce/CBC/controllers/AccountController.dart';
import 'package:ui_ecommerce/res/colors.dart';

class FatoraView extends StatelessWidget {
  FatoraView({super.key});

  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.cbcColor,
        title: Text(
          'رفع فاتورة',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(child: buildContent()),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Get.width * 0.10),
        SizedBox(
          child: Image.asset(
            'assets/images/icons/fatora.png',
            width: Get.width * 0.5,
            height: Get.width * 0.3,
          ),
        ),
        SizedBox(
          child: Text(
            'ملاحظة يجب تحميل الفاتورة مع بطاقتك cbc \n بصورة واحدة وتكون قيمة الخصم واضحة',
            style: TextStyle(
              color: AppColors.cbcColor,
              fontSize: Get.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: Get.width * 0.05),
        searchTextInput(),
        //addressStore(),
        priceDiscount(),
        SizedBox(height: Get.width * 0.05),

        // Add the image upload button and preview
        imageUploadButton(),
        SizedBox(height: Get.width * 0.05),

        // Display the small preview of the image if selected
        Obx(() {
          if (controller.selectedImagePath.isNotEmpty) {
            return Column(
              children: [
                Container(
                  width: Get.width * 0.4,
                  height: Get.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Image.file(
                    File(controller.selectedImagePath.value),  // Display the image from controller
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: Get.width * 0.05),
                button(),
              ],
            );

          } else {
            return Container();  // Return empty container if no image selected
          }
        }),

      ],
    );
  }
  Widget button(){
    return Padding(
      padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
      child: GestureDetector(
        onTap: () {
         controller.uploadImage();
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
    );
  }

  Widget imageUploadButton() {
    return Padding(
      padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
      child: GestureDetector(
        onTap: () async {
          controller.pickImage();
        },
        child: Container(
          height: Get.width * 0.1,
          width: Get.width * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey,
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.image, color: Colors.white),
                Text(
                  'حمل صورة الفاتورة',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.03,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding priceDiscount() {
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
          controller: controller.priceDiscount,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'قيمة الخصم',
            hintStyle: TextStyle(
              fontSize: Get.height * 0.015,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: AppColors.cbcColor,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              borderSide: BorderSide(color: AppColors.cbcColor),
            ),
          ),
        ),
      ),
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: AppColors.cbcColor,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              borderSide: BorderSide(color: AppColors.cbcColor),
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
              if (value != null) {
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: AppColors.cbcColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                borderSide: BorderSide(color: AppColors.cbcColor),
              ),
            ),
          );
        }),
      ),
    );
  }
}
