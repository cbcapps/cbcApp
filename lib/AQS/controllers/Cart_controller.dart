import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ui_ecommerce/AQS/models/CartModel.dart';
late Box BoxCart;
class Cart_controller extends GetxController {
  var isAddedCart = false.obs;
  var isLoadingAdded = false.obs;
  var msgAdded = '';
  var total = 0;
  var priceMonthly = 0;
  var totalCount = 0;

  void PlusAllData() {
    total = 0;
    totalCount = 0;
    for(var i = 0 ; i< BoxCart.length; ++i) {
      var item = BoxCart.getAt(i);
      int price = item.price;
      int count = item.count;
      total += price * count;
      totalCount += count;
    }
    update();
  }

  void updateCounterPlus(title , price , count,id,image, category){
    var counter = count + 1;
    BoxCart.putAt(id, CartModel(price: price, title: title, count: counter, image: image, category: category, item: id,id: id));
    PlusAllData();
    update();
  }
  void updateCounterMin(title , price , count,id,image, category){
    if(count > 1){
      var counter = count - 1;
      BoxCart.putAt(id, CartModel(price: price, title: title, count: counter, image: image, category: category, item: id,id: id));
      PlusAllData();
      update();
    }else{

    }
  }
  void is_existsloading(){
    isAddedCart(false);
    isLoadingAdded(true);
    update();
  }
  void is_loading(){
    msgAdded = 'Loading';
    isAddedCart(true);
    isLoadingAdded(true);
    update();
  }
  void is_loadingDone(){
    msgAdded = 'Done';
    isLoadingAdded(false);
    update();
  }
  void Plus(title , price , count,id,image, category){
    var counter = count + 1;
    BoxCart.putAt(id, CartModel(price: price, title: title, count: counter, image: image, category: category, item: id,id: id));
    PlusAllData();
    update();
  }

  void putDate(title , price , count,id,image, category)  {
    is_loading();
     try{
       if(!BoxCart.containsKey(id)){
         BoxCart.put(id, CartModel(price: price, title: title, count: count, image: image, category: category, item: id,id: id)).whenComplete(() {
           is_loadingDone();
           Cart_controller cart_controller = Get.put(Cart_controller());
           cart_controller.PlusAllData();
         }).onError((error, stackTrace) {
           is_loadingDone();
           msgAdded = "Error";
           update();
         });
       }else{


         is_existsloading();
       }
       isLoadingAdded(false);
       update();
     }catch(err){
       print(err);
     }
  }
  void deleteData(index) {
    BoxCart.deleteAt(index);
    PlusAllData();
    update();
  }
  void deleteAll(){
    BoxCart.clear();
    PlusAllData();
    update();
  }
  @override
  void onInit() {
    PlusAllData();
    print('rady');
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() {
    PlusAllData();
    print('rady');
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    print('close');
    // TODO: implement onClose
    super.onClose();
  }


}