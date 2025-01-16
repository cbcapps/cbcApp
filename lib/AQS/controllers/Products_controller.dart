import 'package:get/get.dart';
import '../Services/RemoteServices.dart';
import '../models/Product.dart';
class Products_Controller extends GetxController {
  dynamic argumentData = Get.arguments;
  var isLoadingItem= false.obs;
  var category = '';
  var subCategory = '';
  int id = 0;
  var productList = <Product>[].obs;
  void fetchProduct(int id) async{
    isLoadingItem(true);
    try {
      var products = await RemoteServices.fetchProductByCate(id);
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
    category = argumentData[0]['category'];
    subCategory = argumentData[0]['subCategory'];
    id = argumentData[0]['id'];
    fetchProduct(id);
    // TODO: implement onInit
    super.onInit();
  }
}