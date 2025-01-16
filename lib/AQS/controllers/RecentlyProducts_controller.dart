import 'package:get/get.dart';

import '../Services/RemoteServices.dart';
import '../models/Product.dart';

class RecentlyProducts_controller extends GetxController{
  var isLoadingItem= false.obs;
  var productList = <Product>[].obs;
  void fetchProducts() async{
    isLoadingItem(true);
    try {
      var products = await RemoteServices.fetchProductsRecently();
      if(products != null){
        productList.value = products;
        isLoadingItem(false);
      }else{
        isLoadingItem(false);
      }
    }finally{
      isLoadingItem(false);
    }
    update();
  }
  @override
  void onInit() {
    fetchProducts();
    // TODO: implement onInit
    super.onInit();
  }

}