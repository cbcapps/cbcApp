import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';

class NewTxtFieldWithTitleAbove extends StatelessWidget {
  const NewTxtFieldWithTitleAbove({
    super.key,
    this.hidePasword = false,
    this.readOnly = false,
    this.prefixWidgetLeft,
    this.sufixWidgetRight,
    this.initialValueCus,
    this.inputFormattersCustom,
    this.controlerCustom,
    this.onChangedCustom,
    this.keyboardTypeCustom,
    this.hintTxtCus,
    required this.titlTxtField,
  });

  final String titlTxtField;
  final bool hidePasword;
  final String? hintTxtCus;
  final String? initialValueCus;
  final Widget? prefixWidgetLeft;
  final Widget? sufixWidgetRight;
  final TextEditingController? controlerCustom;
  final void Function(String)? onChangedCustom;
  final TextInputType? keyboardTypeCustom;
  final List<TextInputFormatter>? inputFormattersCustom;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // width: 327,
            // margin: EdgeInsets.only(bottom: 6,),
            margin:
                EdgeInsetsDirectional.only(bottom: 6, start: Get.width * 0.01),
            child: Text(
              titlTxtField,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Get.width * 0.035,
                fontWeight: FontWeight.bold,
                color: AppColors.cbcColor,
              ),
            ),
          ),
          SizedBox(
            // height: 48,
            child: TextFormField(
              cursorColor: AppColors.cbcColor,
              controller: controlerCustom,
              obscureText: hidePasword,
              onChanged: onChangedCustom,
              keyboardType: keyboardTypeCustom,
              initialValue: initialValueCus,
              inputFormatters: inputFormattersCustom,
              readOnly: readOnly,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                // fillColor: Get.isDarkMode
                //     ? AppColors.grayScale800
                //     : AppColors.whitebackground,
                // filled: true,
                // contentPadding: EdgeInsets.only(top: 11, left: 12),
                contentPadding: EdgeInsetsDirectional.only(start: 10, end: 10),
                hintText: hintTxtCus,
                hintStyle: TextStyle(
                  fontSize: 16,
                  // color: AppColors.grayScale400,
                ),

                prefixIcon: prefixWidgetLeft, // Prefix icon
                suffixIcon: sufixWidgetRight, // Suffix icon
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Border radius of 10
                  borderSide: BorderSide(
                      color:
                          // Get.isDarkMode
                          //     ?
                          AppColors.cbcColor
                      // : AppColors.grayScale100
                      ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.cbcColor,
                  ), // Focused border color and width
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.cbcColor,
                    // Get.isDarkMode
                    //     ? AppColors.grayScale800
                    //     : AppColors.grayScale100
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
