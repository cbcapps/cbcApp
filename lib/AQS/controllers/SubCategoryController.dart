import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/models/SubCategory.dart';
import '../Services/RemoteServices.dart';
class SubCategory_controller extends GetxController{
  var isLoadingCategories = true.obs;
  var categoriesList = <SubCategory>[].obs;
  dynamic argumentData = Get.arguments;
  var title = '';
  var id = 0;
  void fetchCategories(id) async{
    isLoadingCategories(true);
    try {
      var categories = await RemoteServices.fetchSubCategories(id);
      if(categories != null){
        categoriesList.value = categories;
      }else{
        print('some error 1');
      }
    }catch(error){
      print(error);
    }finally{
      isLoadingCategories(false);
    }
    update();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    title = argumentData[0]['title'];
    id =  argumentData[0]['id'];
    fetchCategories(argumentData[0]['id']);
    print('load sub');
    super.onInit();
  }
}