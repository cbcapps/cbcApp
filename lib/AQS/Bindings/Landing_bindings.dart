import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/controllers/Home_controller.dart';
import 'package:ui_ecommerce/AQS/controllers/Landing_controller.dart';
import 'package:ui_ecommerce/AQS/controllers/Login_controller.dart';
import '../../CBC/controllers/Landing_controller.dart';
import '../controllers/Cart_controller.dart';
class Landing_bindings implements Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => Clanding_controller() ,fenix: true);
   Get.lazyPut(() => Landing_controller(),fenix: true);
   Get.lazyPut(() => Login_controller(),fenix: true);
   Get.lazyPut(() => Home_controller() ,fenix: true);
   Get.lazyPut(() => Cart_controller() , fenix: true);

  }
}