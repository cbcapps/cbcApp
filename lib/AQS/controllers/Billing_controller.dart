import 'package:get/get.dart';
import 'package:ui_ecommerce/main.dart';
import 'package:ui_ecommerce/AQS//models/Bill.dart';
import '../Services/RemoteServices.dart';

class Billing_controller extends GetxController{
  var isLoadingBills= true.obs;
  var billsList = <Bill>[].obs;
  int selectedIndex = -1;
  void fetchBills() async{
    var user_id = sharedPreferences!.getInt('user_id');
    isLoadingBills(true);
    try {
      var products;
      if(selectedIndex == 0){
         products = await RemoteServices.fetchLatestBills(user_id);
      }else {
         products = await RemoteServices.fetchBills(user_id);
      }

      if(products != null){
        billsList.value = products;
      }else{

      }
    }finally{
      isLoadingBills(false);
    }
    update();
  }
  void changeSelected(selected){
    selectedIndex = selected;
    fetchBills();
    update();
  }
  void filter(){


  }


  @override
  void onInit() {
    fetchBills();
    // TODO: implement onInit
    super.onInit();
  }
}