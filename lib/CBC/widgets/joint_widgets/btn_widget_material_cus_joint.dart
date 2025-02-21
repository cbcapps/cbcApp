import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../res/height_width_cus.dart';

class BtnWidgetMaterialCustomJoint extends StatelessWidget {
  const BtnWidgetMaterialCustomJoint({
    super.key,
    required this.txtBtn,
    this.onPressed,
  });

  final String txtBtn;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // color: Colors.amber,
      borderRadius: BorderRadius.circular(Get.width * 0.02),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 0,
        // splashColor: Colors.blue.withOpacity(0.8),
        splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        // highlightColor: Colors.blue.withOpacity(0.8),
        highlightColor: Colors.blue.withValues(alpha: 0.8),
        height: heightAppBarCustom(context) * 0.065,
        padding: EdgeInsets.zero,
        color: AppColors.cbcColor,
        child: Text(
          txtBtn,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: Get.width * 0.035,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
