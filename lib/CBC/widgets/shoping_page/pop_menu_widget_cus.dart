import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/res/colors.dart';

class PopMenuWidgetCustom extends StatelessWidget {
  const PopMenuWidgetCustom({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      'الملابس',
      'الحقائب',
      'الاحذية',
      'الاطعمة',
      'الاجهزة',
    ];
    return PopupMenuButton<int>(
      borderRadius: BorderRadius.circular(10),
      // Adjust the width of the popup menu
      constraints: BoxConstraints(
        minWidth: Get.width * 0.3, // Set the minimum width
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      color: AppColors.bakgroundDrop,
      icon: Icon(
        Icons.menu,
        size: 30,
        color: Colors.white,
      ), // The "three dots" icon
      onSelected: (value) {},
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "الاقسام",
                style: TextStyle(
                    fontSize: Get.width * 0.045, fontWeight: FontWeight.bold),
              )),
        ),
        //  list.map((e) => ,).toList(),
        PopupMenuItem(child: buildWidget("الملابس")),
        PopupMenuItem(child: buildWidget('الحقائب')),
        PopupMenuItem(child: buildWidget('الاحذية')),
        PopupMenuItem(child: buildWidget('الاطعمة')),
        PopupMenuItem(child: buildWidget('الاجهزة')),

        /*
            List<String> list = [
      'الملابس',
      'الحقائب',
      'الاحذية',
      'الاطعمة',
      'الاجهزة',
    ];
        */
        // PopupMenuDivider(), // Add a divider between items
        // PopupMenuItem(
        //   value: 3,
        //   child: Row(
        //     children: [
        //       Icon(Icons.settings, color: Colors.black),
        //       SizedBox(width: 8),
        //       Text("Settings"),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  buildWidget(String txt) {
    return Column(
      children: [
        Text(
          txt,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.txtDrop),
        ),
        SizedBox(height: 5),
        Divider(
          color: AppColors.dividerDrop,
          height: 0,
        )
      ],
    );
    // end Method
  }

  // end Class
}
