import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/models/CallCenter.dart';
import 'package:ui_ecommerce/CBC/models/Qr.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Services/RemoteServices.dart';

class HelpController extends GetxController  with SingleGetTickerProviderMixin{
  TabController? tabController;
  var isLoadingCallCenter= true.obs;
  var isLoadingQr= true.obs;
  var qrList = <QrModel>[].obs;
  var callCenterList = <CallCenterModel>[].obs;
  var details = [
    {'title': 'آبرز البطاقة عن الدفع مع هوية اثبات شخصية'},
    {'title': 'تستخدم البطاقة من قبلك فقط ولا يمكن استخدامها من قبل شخص اخر'},
    {'title': 'اطلع بشكل دائمي على التطبيق لوجود تحديثات وعروض لفترات محدودة يمكنك الاستفادة منها'},
    {'title': 'تفعيل الاشعارات عند تثبيت التطبيقات ليصلك كل ماهو جديد'},
    {'title': 'في حال وجود عروض خاصة وقتية من قبل المتجر ولم تذكر في التطبيق بامكانك اختيار خصم التطبيق او عروض الوقتية للمتجر'},
    {'title': 'عند زيارة المطاعم يجب ابراز البطاقة قبل طلب الحساب وذلك لان نظام المحاسب لا يمكن التعديل على فاتورة الحساب بعد حفظها وطباعتها'},
    {'title': 'في حالة عدم حصولك على الخصم المقدم من المتجر يرجى الاتصال او مراسلة خدمة الزبائن فورآ قبل مغادرة المتجر ولكي لا يسقط حقك بالخصم'},
    {'title': 'لا يجوز التفاوض على السعر قبل ابراز بطاقة cbc للخصومات'},
    {'title': 'البطاقة لها فترات صلاحية نافذه مختلفة : 1 سنة و 2 سنة و 4 سنوات'},
  ].obs;
  void fetchCallCenter() async{
    isLoadingCallCenter(true);
    try {
      var list = await RemoteServices.fetchCallCenter();
      if(list != null){
        callCenterList.value = list;
      }else{
        isLoadingCallCenter(false);
      }
    }finally{
      isLoadingCallCenter(false);
    }
    isLoadingCallCenter(false);
    update();
  }

  void fetchQr() async{
    isLoadingQr(true);
    try {
      var list = await RemoteServices.fetchQr();
      if(list != null){
        qrList.value = list;
      }else{
        isLoadingQr(false);
      }
    }finally{
      isLoadingQr(false);
    }
    isLoadingQr(false);
    update();
  }
  void callPhone(phone){
    launchUrlString("tel://${phone}");
  }
  launchWhatsAppUri(phone) async {
    String infoText = '';
    String whatsappUrl =
        "whatsapp://send?phone=$phone" "&text=${Uri.encodeFull(infoText)}";
    try {
      launchUrlString(whatsappUrl);
    } catch (e) {
      //handle error properly
    }
  }
  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    fetchCallCenter();
    fetchQr();
    // TODO: implement onInit
    super.onInit();
  }
}