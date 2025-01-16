import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/Product_controller.dart';
class Product_bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Product_controller());
  }


}