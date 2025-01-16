import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS//controllers/Category_controller.dart';

class Category_bindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Category_controller());
    // TODO: implement dependencies
  }

}