import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/method_utls.dart';
import '../../res/method_widgets.dart';

class CalculatorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // formRegister = GlobalKey();
    billAmountController = TextEditingController();
    percentDiscountController = TextEditingController();
    discountMoneyAmountController = TextEditingController();
    resultAfterDiscountController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    billAmountController.dispose();
    percentDiscountController.dispose();
    discountMoneyAmountController.dispose();
    resultAfterDiscountController.dispose();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  late TextEditingController billAmountController;
  late TextEditingController percentDiscountController;
  late TextEditingController discountMoneyAmountController;
  late TextEditingController resultAfterDiscountController;

  bool checkFieldsMethod() {
    bool billAmount = billAmountController.text.trim().isNotEmpty;
    bool percent = percentDiscountController.text.trim().isNotEmpty;

    if (billAmount && percent) {
      return true;
    } else {
      MethodsWidgetClass.dialogAlertmethod(
          bodyMsg: '207'.tr, titleMsg: '208'.tr);
      return false;
    }

    // end Method
  }

  calculateAmountMethod() {
    if (!checkFieldsMethod()) return;
    double billAmount = double.parse(billAmountController.text.trim());
    int discountPercentage = int.parse(percentDiscountController.text.trim());
    double amountAfterDiscount = 0.0;
    amountAfterDiscount = billAmount - (billAmount * discountPercentage / 100);
    resultAfterDiscountController.text =
        MethodsClassUTls.formatNumber(number: amountAfterDiscount);

    double amountOfDiscountDue = billAmount - amountAfterDiscount;

    discountMoneyAmountController.text =
        MethodsClassUTls.formatNumber(number: amountOfDiscountDue);
  }

  // ==========================
  // end Controller
}
