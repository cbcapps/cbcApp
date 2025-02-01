import 'package:flutter/material.dart';

import '../../../res/colors.dart';

class ProgressCircularWidgetCustom extends StatelessWidget {
  const ProgressCircularWidgetCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.cbcColor,
        strokeWidth: 5,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
