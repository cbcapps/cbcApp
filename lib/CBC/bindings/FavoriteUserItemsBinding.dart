//

import 'package:get/get.dart';

import '../controllers/FavoriteUserItemsControler.dart';

class FavoriteUserItemsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteUserItemsControler>(() => FavoriteUserItemsControler());
    // end Method
  }
}
