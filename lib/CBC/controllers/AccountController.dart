import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_ecommerce/CBC/models/Account.dart';
import 'package:ui_ecommerce/main.dart';

import '../Services/RemoteServices.dart';
import '../models/TestItem.dart';

class AccountController extends GetxController with SingleGetTickerProviderMixin{
  TabController? tabController;
  late TextEditingController phone = TextEditingController();
  late TextEditingController number = TextEditingController();
  late TextEditingController myController = TextEditingController();
  late TextEditingController address = TextEditingController();
  late TextEditingController priceDiscount = TextEditingController();

  var isActive = false.obs;  // For active/inactive account state
  var userName = ''.obs;  // User's name
  var walletNumber = ''.obs;  // Wallet number
  var dateCard = ''.obs;  // Date card or expiry date
  var phoneCard = ''.obs;
  var discountCard = ''.obs;
  var rateStore = ''.obs;

  var isError = false.obs;
  var isFound = false.obs;
  var accountList = <AccountModel>[].obs;
  var isLoadingAccount= true.obs;
  var selectedImagePath = ''.obs;

  // Function to pick image from gallery
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath.value = image.path;
      update();
    } else {
      print("No image selected");
    }
  }


  Future<void> uploadRate() async {


    if (myController.text.isEmpty || rateStore.value.isEmpty) {
      Get.snackbar('خطا', 'الرجاء اختيار تقييم او متجر');
      return;
    }

    if (userName.value.isEmpty) {
      Get.snackbar('خطا', 'الرجاء اضافة بطاقتك');
      return;
    }
    // Call RemoteServices uploadImage method
    String result = await RemoteServices.rateStore(
        myController.text.trim(),
        userName.value,
        rateStore.value
    );
    Get.snackbar('نجح', 'تم ارسال التقييم بنجاح');
  }

  // Function to upload image with storeId and amount
  Future<void> uploadImage() async {

    if (selectedImagePath.isEmpty) {
      Get.snackbar('Error', 'Please select an image first');
      return;
    }

    if (myController.text.isEmpty || priceDiscount.text.isEmpty) {
      Get.snackbar('Error', 'Store ID and Amount are required');
      return;
    }
    if (userName.value.isEmpty) {
      Get.snackbar('خطا', 'الرجاء اضافة بطاقتك');
      return;
    }

    // Call RemoteServices uploadImage method
    String result = await RemoteServices.uploadImage(
      selectedImagePath.value,
      userName.value,
      priceDiscount.text.trim(),
      myController.text.trim()
    );

    if (result == 'Upload successful!') {
      Get.snackbar('نجح', 'تم رفع الفاتورة بنجاح');
    } else {

      Get.snackbar('Error', result);
    }
  }
  void is_error(){
    isError(true);
    update();
  }
  void is_added(){
    isFound(true);
    isError(false);
    update();
  }
  void fetchAccount() async{
    isLoadingAccount(true);
    try {
      var list = await RemoteServices.fetchAccount(number.text.trim());
      if(list != null){
        is_added();
        accountList.value = list;
        print(accountList[0].number);
        sharedPreferences!.setString('nameAccount', accountList[0].nameEn);
        sharedPreferences!.setInt('numberAccount', accountList[0].number);
        sharedPreferences!.setString('dateAccount', accountList[0].date);
        sharedPreferences!.setString('discountAccount', accountList[0].discount.toString());
        sharedPreferences!.setBool('accountActive', true);
        dateCard.value = accountList[0].date.toString();
        walletNumber.value = accountList[0].number.toString();
        userName.value = accountList[0].nameEn;
        discountCard.value =  accountList[0].discount.toString();
        isActive(true);
      }else{
        is_error();
        print('not found');
        isLoadingAccount(false);
      }
    }finally{
      isLoadingAccount(false);
    }
    isLoadingAccount(false);
    update();
  }
  void fetchRefresh() async{
    isLoadingAccount(true);
    sharedPreferences!.clear();
    fetchAccount();
    update();
  }
  Future<List<TestItem>> fetchData() async {
    await Future.delayed(Duration(milliseconds: 2000));
    List<TestItem> _list = [];
    String _inputText = myController.text;
    List<dynamic> filters = await RemoteServices.filterStories(_inputText);
    for (var jsonItem in filters) {
      _list.add(TestItem.fromJson(jsonItem));
    }
    return _list;
  }
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    if(sharedPreferences!.getBool('accountActive') == true){
      userName.value = sharedPreferences!.getString('nameAccount').toString();
      isActive(true);
      number.text = sharedPreferences!.getInt('numberAccount').toString();
      dateCard.value = sharedPreferences!.getString('dateAccount').toString();
      walletNumber.value = sharedPreferences!.getInt('numberAccount').toString();
      userName.value = sharedPreferences!.getString('nameAccount').toString();
      discountCard.value =  sharedPreferences!.getString('discountAccount').toString();
      update();
    }else{
      isActive(false);
      update();
    }
    // TODO: implement onInit
    super.onInit();
  }
}