import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_ecommerce/CBC/controllers/ShopingController.dart';
import 'package:ui_ecommerce/CBC/models/Account.dart';
import 'package:ui_ecommerce/main.dart';

import '../../res/key_sherd_prefs.dart';
import '../../res/method_utls.dart';
import '../../res/method_widgets.dart';
import '../Services/RemoteServices.dart';
import '../models/TestItem.dart';

abstract class AbstractAccountController extends GetxController
    with GetSingleTickerProviderStateMixin {
  changeDiscountFormat();
  closeKeyBoardFatoraMethod();
  closeKeyBoardMethod();
  bool checkFieldsActivateAccount();

  // Backend Methods

  Future<void> fetchAccount(String id, {bool isNotFromBtn = false});

  //  end Abstract Class
}

class AccountController extends AbstractAccountController {
  @override
  void dispose() {
    tabController?.dispose();
    phone.dispose();
    number.dispose();
    myController.dispose();
    address.dispose();
    priceDiscount.dispose();
    focusCardNumbr.dispose();
    focusPhoneNumbr.dispose();
    super.dispose();
    // end Method
  }

  final Shopingcontroller _shopingcontroller = Get.find();

  TabController? tabController;
  late TextEditingController phone = TextEditingController();
  late TextEditingController number = TextEditingController();
  late TextEditingController myController = TextEditingController();
  late TextEditingController address = TextEditingController();
  late TextEditingController priceDiscount = TextEditingController();
  late FocusNode focusCardNumbr;
  late FocusNode focusPhoneNumbr;
  late FocusNode focusNameStoreFatora;
  late FocusNode focusDiscountPriceFatora;

  var isActive = false.obs; // For active/inactive account state
  var isExpired = false.obs; // For active/inactive account state
  bool getAcountStatusLoading = false;
  var userName = ''.obs; // User's name
  var walletNumber = ''.obs; // Wallet number
  var dateCard = ''.obs; // Date card or expiry date
  var phoneCard = ''.obs;
  var discountCard = ''.obs;
  var rateStore = ''.obs;

  var isError = false.obs;
  var isFound = false.obs;
  var accountList = <AccountModel>[].obs;
  var isLoadingAccount = true.obs;
  var selectedImagePath = ''.obs;

  // Function to pick image from gallery
  Future<void> pickImage() async {
    closeKeyBoardFatoraMethod();
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
        myController.text.trim(), userName.value, rateStore.value);
    Get.snackbar('نجح', 'تم ارسال التقييم بنجاح');
  }

  // Function to upload image with storeId and amount
  Future<void> uploadImage() async {
    final numbrCard = sharedPreferences.getInt(KeySherdPrefs.numbrCardCBC);

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
    if (numbrCard == null) {
      Get.snackbar('خطا', 'الرجاء اضافة بطاقتك');
      return;
    }

    MethodsWidgetClass.loadingMethod();

    // Call RemoteServices uploadImage method
    // priceDiscount.text = priceDiscount.text.trim().replaceAll(',', '');

    closeKeyBoardFatoraMethod();

    final priceDiscountFinal = priceDiscount.text.trim().replaceAll(',', '');

    String result = await RemoteServices.uploadImage(selectedImagePath.value,
        numbrCard.toString(), priceDiscountFinal, myController.text.trim());

    // if (result == 'Upload successful!') {
    if (result.contains('successfully')) {
      selectedImagePath.value = '';
      priceDiscount.text = '';
      myController.text = '';
      Get.back();
      Get.snackbar('نجح', 'تم رفع الفاتورة بنجاح');
    } else {
      Get.back();
      Get.snackbar('Error', result);
    }
  }

  void is_error() {
    isError(true);
    update();
  }

  void is_added() {
    isFound(true);
    isError(false);
    update();
  }

  @override
  Future<void> fetchAccount(String id, {bool isNotFromBtn = false}) async {
    isLoadingAccount(true);
    isFound(false);
    isError(false);
    isExpired(false);
    update();
    try {
      List<AccountModel>? list = await RemoteServices.fetchAccountServer(id);
      if (list != null) {
        accountList.value = list;

        final itemAcount = accountList[0];

        print('\n ');
        print('\n ');
        print(
            'Status Card is ${itemAcount.status} And Discount is ${itemAcount.discount} ');
        print('\n ');
        print('\n ');
        // 38242

        if (itemAcount.status == 'Expired') {
          isNotFromBtn ? null : isExpired(true);
          number.text = itemAcount.numberCard.toString();
          // isActive(false);
          update();

          await sharedPreferences.setBool('accountActive', false);
        } else {
          isNotFromBtn ? null : is_added();
          print(accountList[0].numberCard);
          await Future.wait([
            sharedPreferences.setString('nameAccount', itemAcount.nameEn),
            sharedPreferences.setInt(
                KeySherdPrefs.numbrCardCBC, itemAcount.numberCard),
            sharedPreferences.setString('dateAccount', itemAcount.date),
            sharedPreferences.setString(
                'discountAccount', itemAcount.discount.toString()),
            sharedPreferences.setBool('accountActive', true),
          ]);
          dateCard.value = itemAcount.date.toString();
          walletNumber.value = itemAcount.numberCard.toString();
          userName.value = itemAcount.nameEn;
          discountCard.value = itemAcount.discount.toString();
          await _shopingcontroller.callMethodFromOtherController(curentPage: 1);
          isActive(true);

          //End  else If Expired
        }
      } else {
        is_error();
        print('not found');
        isLoadingAccount(false);
      }
    } finally {
      getAcountStatusLoading = false;
      isLoadingAccount(false);
    }
    isLoadingAccount(false);
    update();
    // end Method
  }

  void fetchRefresh() async {
    final check = checkFieldsActivateAccount();

    if (check) {
      // isLoadingAccount(true);
      MethodsWidgetClass.loadingMethod();
      closeKeyBoardMethod();
      sharedPreferences.clear();
      await fetchAccount(number.text.trim());

      Get.back();
      update();
    }
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
    print('\n');
    print(' Instance "AccountController" has been initialized');
    print('\n');
    tabController = TabController(length: 2, vsync: this);

    focusCardNumbr = FocusNode();
    focusPhoneNumbr = FocusNode();
    focusDiscountPriceFatora = FocusNode();
    focusNameStoreFatora = FocusNode();

    if (Get.arguments != null) {
      tabController?.animateTo(1);
    }

    final numbrCardSherd = sharedPreferences.getInt(KeySherdPrefs.numbrCardCBC);

    if (numbrCardSherd != null) {
      print('\n');
      print('The numbrCardSherd Not Null ');
      print('\n');
      getAcountStatusLoading = true;
      update();
      fetchAccount(numbrCardSherd.toString(), isNotFromBtn: true);
    }

    if (sharedPreferences!.getBool('accountActive') == true) {
      userName.value = sharedPreferences!.getString('nameAccount').toString();
      isActive(true);
      number.text = numbrCardSherd.toString();
      dateCard.value = sharedPreferences!.getString('dateAccount').toString();
      walletNumber.value =
          sharedPreferences!.getInt(KeySherdPrefs.numbrCardCBC).toString();
      userName.value = sharedPreferences!.getString('nameAccount').toString();
      discountCard.value =
          sharedPreferences.getString('discountAccount').toString();
      update();

      print('\n');
      print(
          'The Number Card CBC is ${number.text} And Discount is $discountCard');
      print('\n');
    } else {
      isActive(false);
      update();
    }

    super.onInit();
  }

  @override
  bool checkFieldsActivateAccount() {
    bool chekcCardNumbr = number.text.trim().isNotEmpty;
    bool checkPhoneNumber = phone.text.trim().length >= 10;

    if (chekcCardNumbr && checkPhoneNumber) {
      return true;
    } else {
      if (!chekcCardNumbr) {
        MethodsWidgetClass.dialogAlertmethod(
            bodyMsg: '225'.tr, titleMsg: '208'.tr);
        return false;
      } else if (!checkPhoneNumber) {
        MethodsWidgetClass.dialogAlertmethod(
            bodyMsg: '226'.tr, titleMsg: '208'.tr);
        return false;
      }

      return false;
    }
    // end Method
  }

  @override
  closeKeyBoardMethod() {
    focusCardNumbr.unfocus();
    focusPhoneNumbr.unfocus();
    focusDiscountPriceFatora.unfocus();
    focusNameStoreFatora.unfocus();
    // end Method
  }

  @override
  changeDiscountFormat() {
    try {
      String txtBill = priceDiscount.text;

      if (txtBill.contains(',')) {
        txtBill.trim().replaceAll(',', '');
      }

      priceDiscount.text = MethodsClassUTls.formatNumber(
          number: double.parse(priceDiscount.text) + 0.0);
    } catch (e) {
      priceDiscount.text = '';
    }
    // end Method
  }

  @override
  closeKeyBoardFatoraMethod() {
    focusDiscountPriceFatora.unfocus();
    focusNameStoreFatora.unfocus();
    // end Method
  }
}
