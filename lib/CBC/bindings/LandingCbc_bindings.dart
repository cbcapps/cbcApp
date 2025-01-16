import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Landing_controller.dart';

class LandingCbc_bindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => Clanding_controller());
    // TODO: implement dependencies
  }

}