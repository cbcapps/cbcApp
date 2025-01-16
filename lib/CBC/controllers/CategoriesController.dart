import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/models/Category.dart';
import '../Services/RemoteServices.dart';
class CategoriesController extends GetxController {
  var isLoadingCategories= true.obs;
  int id = 0;
  dynamic argumentData = Get.arguments;
  String? city;
  var categoriesList = <Category>[].obs;
  void fetchRecently() async{
    isLoadingCategories(true);
    try {
      var list = await RemoteServices.fetchCategories(id);
      if(list != null){
        categoriesList.value = list;
      }else{
        isLoadingCategories(false);
      }
    }finally{
      isLoadingCategories(false);
    }
    isLoadingCategories(false);
    update();
  }
  @override
  void onInit() {
    id = argumentData[0]['id'];
    city = argumentData[0]['city'];
    fetchRecently();
    super.onInit();
  }
}