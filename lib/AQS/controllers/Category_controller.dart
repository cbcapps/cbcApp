import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/models/Category.dart';

import '../Services/RemoteServices.dart';

class Category_controller extends GetxController{
  var isLoadingCategories = true.obs;
  var categoriesList = <CategoryModel>[].obs;
  void fetchCategories() async{
    isLoadingCategories(true);
    try {
      var categories = await RemoteServices.fetchCategories();
      if(categories != null){
        categoriesList.value = categories;
      }else{
      }
    }finally{
      isLoadingCategories(false);
    }
    update();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchCategories();
    super.onInit();
  }
}