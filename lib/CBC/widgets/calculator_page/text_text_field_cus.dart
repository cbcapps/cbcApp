import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../res/height_width_cus.dart';

class TextTextFieldCustom extends StatelessWidget {
  TextTextFieldCustom({
    super.key,
    required this.txtTitle,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.redOnly = false,
  });

  final String txtTitle;
  final bool redOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final InputBorder outLineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Get.width * 0.02),
    borderSide: const BorderSide(
      color: AppColors.cbcColor,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // height: 30,
          width: Get.width * 0.36,
          // color: Colors.red,

          child: Text(
            txtTitle,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: Get.width * 0.03,
              fontWeight: FontWeight.bold,
              color: AppColors.cbcColor,
            ),
          ),
        ),
        SizedBox(width: Get.width * 0.02),
        Container(
          height: heightAppBarCustom(context) * 0.037,
          width: Get.width * 0.4,
          // color: Colors.blue,
          child: TextFormField(
            cursorHeight: heightAppBarCustom(context) * 0.02,
            controller: controller,
            readOnly: redOnly,
            keyboardType:
                keyboardType ?? TextInputType.numberWithOptions(decimal: true),
            inputFormatters: inputFormatters ??
                [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^\d*\.?\d*$')), // Regex to allow numbers and decimal
                ],
            style: TextStyle(
              fontSize: Get.width * 0.032,
              color: AppColors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsetsDirectional.only(start: 10, end: 10),
              hintStyle: TextStyle(
                fontSize: Get.width * 0.032,
              ),
              border: outLineBorder,
              focusedBorder: outLineBorder,
              enabledBorder: outLineBorder,
            ),
          ),
        ),
      ],
    );
  }
}
