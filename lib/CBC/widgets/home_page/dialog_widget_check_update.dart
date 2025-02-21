import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../res/height_width_cus.dart';
import '../../controllers/Home_controller.dart';
import '../joint_widgets/btn_widget_material_cus_joint.dart';

class DialogWidgetCheckUpdateCus extends StatelessWidget {
  DialogWidgetCheckUpdateCus(
      {super.key,
      this.onPressedCus,
      required this.checkBoxValue,
      this.onChangedCheckBox});

  final Function()? onPressedCus;
  final bool checkBoxValue;
  final void Function(bool?)? onChangedCheckBox;

  final Chome_controller _chome_controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final heightDialog = Get.locale == Locale('ar', 'IQ')
        ? Get.height * 0.32
        : Get.height * 0.35;

    return Container(
      //  borderRadius: BorderRadius.circular(Get.width * 0.05),
      child: SizedBox(
        height: heightDialog,
        // width: double.infinity,
        width: Get.width * 0.9,
        // color: Colors.red,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            // Get.locale == Locale('ar', 'IQ')
            //     ? SizedBox(height: Get.height * 0.0)
            //     : SizedBox.shrink(),
            Text(
              '228'.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Get.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025),
              child: Text(
                '227'.tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: Get.height * 0.02),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            //   child: BtnWidgetMaterialCustomJoint(
            //     txtBtn: '229'.tr,
            //     onPressed: onPressedCus,
            //   ),
            // ),

            buillRemindWidget(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildWidgetBtn(
                  context,
                  '232'.tr,
                  colorBtn: Colors.red,
                  colorSplash: Colors.redAccent,
                  onPressed: () => Get.back(),
                ),
                buildWidgetBtn(context, '229'.tr, onPressed: onPressedCus),
              ],
            ),
            // end Children ListView
          ],
        ),
      ),
    );
  }

  buildWidgetBtn(BuildContext context, String txt,
      {Color? colorSplash, Color? colorBtn, void Function()? onPressed}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Get.width * 0.02),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 0,
        // splashColor: Colors.blue.withOpacity(0.8),
        splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        // highlightColor: Colors.blue.withOpacity(0.8),
        highlightColor: colorSplash ?? Colors.blue.withValues(alpha: 0.8),
        height: heightAppBarCustom(context) * 0.065,
        minWidth: Get.width * 0.2,
        // padding: EdgeInsets.zero,
        color: colorBtn ?? AppColors.cbcColor,

        child: Text(
          txt,
          style: TextStyle(
            fontSize: Get.width * 0.035,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
    // end Method
  }

  buillRemindWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width * 0.02,
        ),
        GetBuilder<Chome_controller>(builder: (_) {
          return Checkbox(
            value: _chome_controller.remindMeCheck,
            // fillColor: Colors.greenAccent,
            activeColor: Colors.green,
            onChanged: onChangedCheckBox,
            // Customize the checkbox shape with rounded corners
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          );
        }),
        // const SizedBox(width: 8),
        Text(
          // 'Some text goes here',
          '233'.tr,
          // style: TextStyle(fontSize: 16),
          style: TextStyle(
            fontSize: Get.width * 0.035,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
    // end Method
  }
  // end Class
}
