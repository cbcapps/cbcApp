import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/res/colors.dart';

import '../../res/height_width_cus.dart';
import '../../res/images_path.dart';
import '../controllers/CalculatorController.dart';
import '../widgets/calculator_page/text_text_field_cus.dart';
import '../widgets/joint_widgets/appbar_shoping_ofers_page_cus.dart';

class Calculatorscreen extends StatelessWidget {
  Calculatorscreen({super.key});

  final CalculatorController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarShopingOfersPageCustom(
          AppImages.logoCbcEmpty,
          '198'.tr,
          Get.height * 0.03,
          Get.width * 0.1,
          Container(),
          Container(),
          true,
          false),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        children: [
          //

          sizedBoxCustom(context, 0.03),

          Container(
            height: heightAppBarCustom(context) * 0.2,
            child: Image.asset(AppImages.calculatorPng),
          ),
          sizedBoxCustom(context, 0.035),

          Row(
            children: [
              Container(
                height: heightAppBarCustom(context) * 0.05,
                width: Get.width * 0.02,
                decoration: BoxDecoration(
                    color: AppColors.cbcRed,
                    borderRadius: BorderRadius.circular(Get.width * 0.05)),
              ),
              SizedBox(width: Get.width * 0.02),
              SizedBox(
                width: Get.width * 0.83,
                child: Text(
                  '199'.tr,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: Get.width * 0.035,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cbcColor,
                  ),
                ),
              ),
            ],
          ),

          sizedBoxCustom(context, 0.035),

          // Width 90%
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.045, vertical: Get.width * 0.05),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Get.width * 0.03),
                border: Border.all(color: Colors.grey)),

            // Width 80%
            child: Column(
              children: [
                //
                TextTextFieldCustom(
                  txtTitle: '200'.tr,
                  controller: _controller.billAmountController,
                  onChanged: (p0) {
                    _controller.changeTextBillAmount();
                  },
                ),

                sizedBoxCustom(context, 0.02),
                TextTextFieldCustom(
                  txtTitle: '201'.tr,
                  controller: _controller.percentDiscountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter
                        .digitsOnly, // Allows digits only
                  ],
                ),

                sizedBoxCustom(context, 0.02),
                Text(
                  '202'.tr,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Get.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cbcRed,
                  ),
                ),

                sizedBoxCustom(context, 0.025),

                ClipRRect(
                  borderRadius: BorderRadius.circular(Get.width * 0.02),
                  child: SizedBox(
                    height: heightAppBarCustom(context) * 0.037,
                    width: Get.width * 0.5,
                    child: MaterialButton(
                      elevation: 0,
                      focusElevation: 0,
                      hoverElevation: 0,
                      highlightElevation: 0,
                      color: Colors.amberAccent,
                      highlightColor: Colors.amber,
                      onPressed: () {
                        _controller.calculateAmountMethod();
                      },
                      child: Text(
                        '203'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Get.width * 0.03,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cbcColor,
                        ),
                      ),
                    ),
                  ),
                ),

                sizedBoxCustom(context, 0.025),

                TextTextFieldCustom(
                  txtTitle: '204'.tr,
                  redOnly: true,
                  controller: _controller.discountMoneyAmountController,
                ),

                sizedBoxCustom(context, 0.02),
                TextTextFieldCustom(
                  txtTitle: '205'.tr,
                  redOnly: true,
                  controller: _controller.resultAfterDiscountController,
                ),
              ],
            ),
          ),

          // -----------------
        ],
      ),
    );
  }

  sizedBoxCustom(BuildContext context, double percent) {
    return SizedBox(height: heightAppBarCustom(context) * percent);
    // end Method
  }
  // end Class
}



  /*
   NewTxtFieldWithTitleAbove(
            titlTxtField: '200'.tr,
            keyboardTypeCustom: TextInputType.numberWithOptions(decimal: true),
            inputFormattersCustom: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*$')), // Regex to allow numbers and decimal
            ],
          ),
          SizedBox(height: heightAppBarCustom(context) * 0.02),
          NewTxtFieldWithTitleAbove(
            titlTxtField: '201'.tr,
            keyboardTypeCustom: TextInputType.numberWithOptions(decimal: true),
            inputFormattersCustom: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*$')), // Regex to allow numbers and decimal
            ],
          ),

          SizedBox(height: heightAppBarCustom(context) * 0.03),
          Text(
            '202'.tr,
            // maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: Get.width * 0.037,
              fontWeight: FontWeight.bold,
              color: AppColors.cbcRed,
            ),
          ),
          SizedBox(height: heightAppBarCustom(context) * 0.035),

          //  Btn
          // ================================================
          BtnWidgetMaterialCustomJoint(
            txtBtn: '203'.tr,
          ),
          // ================================================

          SizedBox(height: heightAppBarCustom(context) * 0.03),

          NewTxtFieldWithTitleAbove(
            titlTxtField: '204'.tr,
            readOnly: true,
          ),
          SizedBox(height: heightAppBarCustom(context) * 0.02),
          NewTxtFieldWithTitleAbove(
            titlTxtField: '205'.tr,
            readOnly: true,
          ),
  */ 