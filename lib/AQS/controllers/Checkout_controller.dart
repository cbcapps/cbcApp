import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/Services/RemoteServices.dart';
import 'package:ui_ecommerce/AQS/controllers/Cart_controller.dart';
import 'package:ui_ecommerce/main.dart';
class Checkout_controller extends GetxController{
  int total = 0;
  var isPay = false.obs;
  int price  = 0;
  int delivery = 25000;
  int currentStep = 0;
  var user_id ;
  var selectedMonthly = 12.obs;

  void updateMonthly(value){
    selectedMonthly.value = value;
    update();

  }
  @override
  void onInit() {
    price = Get.arguments[0]['total'];
    user_id = sharedPreferences?.getInt('user_id');
    total = price + delivery;
    // TODO: implement onInit
    super.onInit();
  }
  void ContinueStap(){
    if (currentStep < 2) {
      currentStep += 1;
    } else {
      // Handle last step actions (e.g., submitting)
      // You can add your logic here
    }
    update();
  }
  Future<bool> addBill(name,phone,city,address,price,delivery,items) async{
    var list = <Map<String, dynamic>>[];
    for (int x = 0; x < BoxCart.length; x++) {
      var cartItem = BoxCart.getAt(x);
      // Convert cartItem to Map<String, dynamic> if needed
      var mappedItem = {
        'title': cartItem.title,
        'image': cartItem.image,
        'count': cartItem.count,
        'id':    cartItem.id,
        'price': cartItem.price,
      };
      list.add(mappedItem);
    }
    var result = await RemoteServices.addBill(name, phone, city, address, price, delivery, list , user_id);
      if(result.contains('successfully')){
        isPay(true);
        Cart_controller c = Get.put(Cart_controller());
        c.deleteAll();
        c.PlusAllData();
        update();
        return true;
      }else{
        return false;
      }
  }


  void CancelStap(){
    if (currentStep > 0) {
      currentStep -= 1;
    } else {
      currentStep = 0;
    }
    update();
  }

}