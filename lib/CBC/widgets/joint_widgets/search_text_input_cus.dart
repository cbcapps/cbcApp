import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../res/colors.dart';

class SearchTextInputCustom extends StatelessWidget {
  const SearchTextInputCustom({
    super.key,
    required this.controllerCus,
    required this.hintTxt,
    this.futureFunction,
    this.getSelectedValueCus,
  });

  final String hintTxt;
  final TextEditingController controllerCus;
  final Function? futureFunction;
  final Function? getSelectedValueCus;
  @override
  Widget build(BuildContext context) {
    return TextFieldSearch(
      label: 'My Label',
      minStringLength: 1,
      controller: controllerCus,
      future: futureFunction,
      getSelectedValue: getSelectedValueCus,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintTxt,
        hintStyle: TextStyle(
          fontSize: Get.height * 0.015,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.cbcColor,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.cbcColor,
          ),
        ),
        suffixIcon: Container(
          decoration: const BoxDecoration(
            color: AppColors.cbcColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          child:
              Icon(Icons.search, color: Colors.white, size: Get.height * 0.03),
        ),
      ),
    );
  }
}
