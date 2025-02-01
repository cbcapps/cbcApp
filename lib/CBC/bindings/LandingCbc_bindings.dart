import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Landing_controller.dart';

import '../controllers/CalculatorController.dart';
import '../controllers/OfferesController.dart';
import '../controllers/ShopingController.dart';

class LandingCbc_bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Clanding_controller(), fenix: true);

    Get.lazyPut<Shopingcontroller>(() => Shopingcontroller());
    Get.lazyPut<OffersController>(() => OffersController());
    Get.lazyPut<CalculatorController>(() => CalculatorController());
    // end Method
  }
}
