import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/models/ProductPage.dart';
import '../Services/RemoteServices.dart';

class Product_controller extends GetxController {
  var isLoadingItem= false.obs;
  var productList = <ProductPage>[].obs;
  int index = 0;
  var rate  = 3.0;
  int count = 1;
  int total = 0;
  int id = 0;
  dynamic argumentData = Get.arguments;
  void fetchProduct() async{
    isLoadingItem(true);
    try {
      var products = await RemoteServices.fetchProductone(id);
      if(products != null){
        productList.value = [products];
        isLoadingItem(false);
      }else{
        isLoadingItem(false);
      }
    }finally{
      isLoadingItem(false);
    }
    update();
  }

  void changeindex(int i){
    index = i;
    update();
  }
  void inCounter(){
    count++;
    update();
  }
  void outCounter(){
    if(count != 1)
    count --;
    update();
  }
  @override
  void onInit() {
    id = argumentData[0]['id'];
    fetchProduct();
    // TODO: implement onInit
    super.onInit();
  }
}