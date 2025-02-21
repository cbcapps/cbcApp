import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../models/TestItem.dart';
import '../loading_widget/progress_circular_cus.dart';

class SearchTxtFieldTypeAheadCustom extends StatelessWidget {
  const SearchTxtFieldTypeAheadCustom({
    super.key,
    required this.suggestionsCallbackCus,
    required this.myFocusNode,
    required this.myController,
    this.onSelectedCus,
  });

  final FutureOr<List<TestItem>?> Function(String) suggestionsCallbackCus;
  final void Function(TestItem)? onSelectedCus;
  final TextEditingController myController;
  final FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.78,
      height: Get.height * 0.05,
      child: TypeAheadField<TestItem>(
        debounceDuration: Duration(milliseconds: 500),
        errorBuilder: (context, error) => Text('Error Happen'),
        emptyBuilder: (context) => Text('Empty builder'),

        hideOnEmpty: true,
        controller: myController,
        focusNode: myFocusNode,
        hideWithKeyboard: false,

        suggestionsCallback: suggestionsCallbackCus,
        // (search) {
        //   // return list;
        //   List<String> Item = [];
        //   //  suggestionsCallback(search);

        //   print('\n');
        //   print('The Item List is $Item');
        //   print('\n');

        //   if (Item.isEmpty) {
        //     // Item = ['Now Wow'];
        //   }

        //   return Future.value(Item);
        // },
        // controller: textEditingController,
        // focusNode: focusNodeCus,
        builder: (context, controller, focusNode) {
          return buildTextField(controller, focusNode);
        },
        // autoFlipDirection: true,
        // retainOnLoading: false,
        loadingBuilder: (context) {
          return Container(
            height: Get.height * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Get.width * 0.03),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade400),
              ],
            ),
            child: ProgressCircularWidgetCustom(),
          );
        },

        itemBuilder: (context, item) {
          // return ListTile(
          //   title: Text(city.label),
          //   subtitle: Text(city.label),
          // );
          return builwWidgetToShow(item);
        },
        // direction: VerticalDirection.up,
        // itemSeparatorBuilder: (context, index) {
        //   return Container(
        //     height: 10,
        //     color: Colors.amber,
        //   );
        // },
        // listBuilder: (context, children) {
        //   return Container(
        //     height: 200,
        //     color: Colors.red,
        //     child: ListView(
        //       children: [
        //         children.first,
        //         children.first,
        //         children.first,
        //         children.first,
        //         children.first,
        //         children.first,
        //       ],
        //     ),
        //   );
        // },
        onSelected: onSelectedCus,
        autoFlipMinHeight: 100,
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.65,
          // minHeight: Get.height * 0.3,
        ),
        // decorationBuilder: (context, child) {
        //   return Container(
        //     margin: EdgeInsets.only(bottom: Get.height * 0.06),
        //     decoration: BoxDecoration(
        //         color: Colors.amber,
        //         borderRadius: BorderRadius.circular(Get.width * 0.02)),
        //   );
        // },

        //  (city) {
        //   // Navigator.of(context).push<void>(
        //   //   MaterialPageRoute(
        //   //     builder: (context) => CityPage(city: city),
        //   //   ),
        //   // );
        // },
      ),
    );
  }

  Widget buildSufixIcon() {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.cbcColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Icon(Icons.search, color: Colors.white, size: Get.height * 0.03),
    );
    // end Method
  }

  Widget buildTextField(
      TextEditingController? controller, FocusNode? focusNode) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: AppColors.cbcColor,
      ),
    );
    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: false,
      decoration: InputDecoration(
        // border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,

        hintStyle: TextStyle(
          fontSize: Get.height * 0.015,
        ),
        focusedBorder: border,
        enabledBorder: border,
        hintText: '88'.tr,
        suffixIcon: buildSufixIcon(),

        // labelText: 'City',
      ),
    );
  }

  Widget builwWidgetToShow(TestItem item) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.0035, horizontal: Get.width * 0.02),
            child: Text(
              item.label,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: TextStyle(
                fontSize: Get.width * 0.043,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(
            height: 0,
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }
}
