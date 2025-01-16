import 'package:get/get.dart';

class togatherController extends GetxController {
  int index = 0;
  void setIndex(value){
    index = value;
    update();
  }

}