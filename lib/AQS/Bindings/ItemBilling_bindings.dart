import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/ItemBilling_controller.dart';

class ItemBilling_bindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ItemBilling_controller());
    // TODO: implement dependencies
  }

}