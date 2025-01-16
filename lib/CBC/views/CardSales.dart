import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ui_ecommerce/CBC/controllers/StorePageController.dart';
import '../../main.dart';
import '../../res/colors.dart';
import '../controllers/CardController.dart';

class cardSales extends StatelessWidget {
  cardSales({super.key});
  final CardController controller = Get.put(CardController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: Get.width * 0.05, end: Get.width * 0.05, top: Get.width * 0.05),
        child: RefreshIndicator(
          onRefresh: () async{
            controller.fetchCardSale();
          },
          child: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Text(
                '116'.tr,
                style: TextStyle(
                    color: AppColors.cbcColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.03),
              ),
              SizedBox(
                height: Get.width * 0.02,
              ),
              Text(
                '117'.tr,
                style: TextStyle(
                    color: AppColors.cbcRed,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.035),
              ),
              SizedBox(
                height: Get.width * 0.02,
              ),
             _select3(),

              SizedBox(
                height: Get.width * 0.02,
              ),
              Text(
                '183'.tr,
                style: TextStyle(
                    color: AppColors.cbcColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.035
                ),
              ),
              SizedBox(
                height: Get.width * 0.02,
              ),

              //sales
              Container(
                margin: EdgeInsets.only(left: Get.width * 0.02 , right: Get.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    spaceW(Get.width * 0.13),
                    Text(
                      '114'.tr,
                      style: TextStyle(
                        color: AppColors.cbcRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    spaceW(Get.width * 0.2),
                    Text(
                      '115'.tr,
                      style: TextStyle(
                        color: AppColors.cbcRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (!controller.isLoadingType.value) {
                  if (controller.cardType != null) {
                    return (controller.selectedComp.value == 'بدون مؤسسة')? typesAnother() : types();
                  } else {
                    return Center(
                      child: Text(
                        '${'20'.tr}',
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: SpinKitWave(
                      color: AppColors.cbcColor,
                      size: Get.width * 0.1,
                    ),
                  );
                }
              }),
              SizedBox(
                height: Get.width * 0.03,
              ),
              line(),
              SizedBox(
                height: Get.width * 0.05,
              ),
              Text(
                '185'.tr,
                style: TextStyle(
                    color: AppColors.cbcRed,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.035),
              ),
              infoPerson(),
              _payment(),
              SizedBox(
                height: Get.width * 0.15,
              ),



            ],
          ),
        ),
      ),
    );
  }
  _payment(){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.02 , end: Get.width * 0.02),
      child:  GetBuilder<CardController>(builder: (builder){
        if(builder.isLoadingAdded.value){
          return loading_button();
        }else{
          return botton();
        }
      }),
    );
  }
  loading_button(){
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.black,
        size: 20,
      ),);
  }
  botton(){
    return GetBuilder<CardController>(builder: (builder){
      return Center(
        child: GestureDetector(
          onTap: () async {
            if (_areFieldsEmpty()) {
              Get.snackbar('67'.tr, '66'.tr , colorText: AppColors.aqsfullGreen, backgroundColor: Colors.white);
            } else {
              await controller.addOrder();
              if(!builder.isLoadingAdded.value){
                if(builder.isPay.value){
                  Get.snackbar('55'.tr, '190'.tr , colorText: AppColors.aqsfullGreen, backgroundColor: Colors.white);
                }else{
                  Get.snackbar('67'.tr, '25'.tr , colorText: AppColors.aqsfullGreen, backgroundColor: Colors.white);
                }
              }else{
                print('some error');
              }
            }
          },
          child: Container(
            width: Get.width * 0.6,
            height: Get.width * 0.1,
            decoration: BoxDecoration(
                color: AppColors.cbcColor,
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Center(
              child: Text('189'.tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.height * 0.013,
                      fontWeight: FontWeight.bold
                  )),
            ),
          ),
        ),
      );
    });
  }
  msgAdded(title , msg){
    return Get.snackbar(title, msg , colorText: AppColors.aqsfullGreen, backgroundColor: Colors.white);
  }
  infoPerson(){
    return Container(
      margin: EdgeInsets.only(left: Get.width * 0.02 , right: Get.width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _space(Get.height * 0.02),
          _text("186" , Get.height * 0.015,Colors.black,FontWeight.w600),
          _space(Get.height * 0.012),
          _textme("56" , controller.namePerson, false),
          _space(Get.height * 0.02),
          //phone Person
          _text("3" , Get.height * 0.015,Colors.black,FontWeight.w600),
          _space(Get.height * 0.012),
          _textme("3" , controller.phonePerson, false),
          _space(Get.height * 0.02),
          //city
          _text("57" , Get.height * 0.015,Colors.black,FontWeight.w600),
          _space(Get.height * 0.012),
          _select(),
          _space(Get.height * 0.02),
          //address
          _text("188" , Get.height * 0.015,Colors.black,FontWeight.w600),
          _space(Get.height * 0.012),
          _select2(),
          _space(Get.height * 0.02),
          //poing
          _text("187" , Get.height * 0.015,Colors.black,FontWeight.w600),
          _space(Get.height * 0.012),
          _textme("187" , controller.addressPerson, false),
          _space(Get.height * 0.02),
          //
        ],
      ),
    );
  }
  bool _areFieldsEmpty() {
    // Check if required fields are empty
    return controller.namePerson.text.isEmpty ||
        controller.phonePerson.text.isEmpty ||
        controller.selectedCity.value.isEmpty ||
        controller.addressPerson.text.isEmpty;
  }
  _select3(){
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Get.width * 0.015,
        end: Get.width * 0.015,
      ),
      child: GetBuilder<CardController>(builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black, width: 0.3),
          ),
          width: Get.width * 0.9,
          height: Get.width * 0.12,
          child: (!controller.isLoadingComps.value) ? DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
              ),
              isExpanded: true,
              hint: Text(
                '188'.tr,
                style: TextStyle(
                  fontSize: Get.height * 0.014,
                  color: Colors.grey,
                ),
              ),
              items: controller.compsList.value
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: Get.height * 0.014,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))
                  .toList(),
              value: controller.selectedComp.value.isEmpty
                  ? null
                  : controller.selectedComp.value,
              onChanged: (value) {
                controller.selectedComp.value = value ?? '';
                controller.update(); // To refresh the UI after selection
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ) : loading_button(),
        );
      }),
    );
  }
  _select2(){
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Get.width * 0.015,
        end: Get.width * 0.015,
      ),
      child: GetBuilder<CardController>(builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black, width: 0.3),
          ),
          width: Get.width * 0.9,
          height: Get.width * 0.12,
          child: (!controller.isLoadingSubCity.value) ? DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
              ),
              isExpanded: true,
              hint: Text(
                '188'.tr,
                style: TextStyle(
                  fontSize: Get.height * 0.014,
                  color: Colors.grey,
                ),
              ),
              items: controller.subCityList.value
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: Get.height * 0.014,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))
                  .toList(),
              value: controller.selectedCity.value.isEmpty
                  ? null
                  : controller.selectedCity.value,
              onChanged: (value) {
                controller.selectedCity.value = value ?? '';
                controller.update(); // To refresh the UI after selection
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ) : loading_button(),
        );
      }),
    );
  }
  _select(){
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Get.width * 0.015,
        end: Get.width * 0.015,
      ),
      child: GetBuilder<CardController>(builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black, width: 0.3),
          ),
          width: Get.width * 0.9,
          height: Get.width * 0.12,
          child: (!controller.isLoadingCity.value) ? DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
              ),
              isExpanded: true,
              hint: Text(
                '188'.tr,
                style: TextStyle(
                  fontSize: Get.height * 0.014,
                  color: Colors.grey,
                ),
              ),
              items: controller.cityList.value
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: Get.height * 0.014,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))
                  .toList(),
              value: controller.selectedFullCity.value.isEmpty
                  ? null
                  : controller.selectedFullCity.value,
              onChanged: (value) {
                controller.selectedFullCity.value = value ?? '';
                controller.fetchRecently();
                controller.update(); // To refresh the UI after selection
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ) : loading_button(),
        );
      }),
    );
  }
  SizedBox _space(double size){
    return SizedBox(
      height: size,
    );
  }
  _text(String title , double size , Color color , FontWeight fontWeight ){
    return Padding(
      padding: EdgeInsetsDirectional.only(start: Get.width * 0.015),
      child: Text(title.tr,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight,
            color : color
        ),
      ),

    );
  }
  Padding _textme(String title , TextEditingController textEditingController , bool ispassword ){
    return Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.015, end: Get.width * 0.015 ),
      child: TextField(

        style: TextStyle(
            fontSize: Get.height * 0.014
        ),
        obscureText: ispassword,
        controller: textEditingController,
        decoration:   InputDecoration(
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.black, width: 0.1),
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.black, width: 0.1),
            ),
            hintText: title.tr,
            hintStyle: TextStyle(
                color: Colors.grey
            )
        ),
      ),
    );
  }
  line() {
    return Container(
      margin: EdgeInsets.only(right: Get.width * 0.05 , left: Get.width * 0.05),
      width: 200,
      height: Get.width * 0.003,
      color: AppColors.cbcColor,
    );
  }
  Widget types() {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
        padding: EdgeInsetsDirectional.only(
          start: Get.width * 0.01,
          end: Get.width * 0.01,
        ),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: Get.width * 0.02),
            child: GestureDetector(
              onTap: (){
                  controller.updateType1(controller.cardType!.type[index].id);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => Radio<int>(
                    value: controller.cardType!.type[index].id,
                    activeColor: AppColors.aqsfullGreen,
                    groupValue: controller.selectedType1.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateType1(value);
                      }
                    },
                  )),
                  Container(
                    margin: EdgeInsets.only(left: Get.width * 0.02 , right: Get.width * 0.02),
                    width: Get.width * 0.7,
                    padding: EdgeInsets.all(Get.width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.cbcColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          controller.cardType!.type[index].type ?? 'No type',
                          style: TextStyle(
                            fontSize: Get.height * 0.0115,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${formatter.format(controller.cardType!.type[index].price)} دينار عراقي',
                          style: TextStyle(
                            fontSize: Get.height * 0.0115,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),
    );
  }
  Widget typesAnother() {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
        padding: EdgeInsetsDirectional.only(
          start: Get.width * 0.01,
          end: Get.width * 0.01,
        ),
        itemCount: controller.cardType!.type.length >= 2 ? 2 : controller.cardType!.type.length,
        itemBuilder: (BuildContext context, int index) {
          index = controller.cardType!.type.length - 2 + index;
          return Padding(
              padding: EdgeInsets.only(top: Get.width * 0.02),
              child: GestureDetector(
                onTap: (){
                  controller.updateType1(controller.cardType!.type[index].id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() => Radio<int>(
                      value: controller.cardType!.type[index].id,
                      activeColor: AppColors.aqsfullGreen,
                      groupValue: controller.selectedType1.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.updateType1(value);
                        }
                      },
                    )),
                    Container(
                      margin: EdgeInsets.only(left: Get.width * 0.02 , right: Get.width * 0.02),
                      width: Get.width * 0.7,
                      padding: EdgeInsets.all(Get.width * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.cbcColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            controller.cardType!.type[index].type ?? 'No type',
                            style: TextStyle(
                              fontSize: Get.height * 0.0115,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${formatter.format(controller.cardType!.type[index].price)} دينار عراقي',
                            style: TextStyle(
                              fontSize: Get.height * 0.0115,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          );
        },
      ),
    );
  }

  SizedBox spaceH(double size) {
    return SizedBox(
      height: size,
    );

  }
  SizedBox spaceW(double size) {
    return SizedBox(
      width: size,
    );
  }
  sales(){
    return SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: controller.cardSale!.citiesWithSales.length, // عدد المحافظات
          itemBuilder: (BuildContext context, int index) {
            var city = controller.cardSale!.citiesWithSales[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Text(city.title, style: TextStyle(fontWeight: FontWeight.bold)),
                children: [
                  GridView.builder(
                    shrinkWrap: true, // هذا يجعل الGridView يأخذ المساحة اللازمة فقط
                    physics: const NeverScrollableScrollPhysics(), // يمنع التمرير داخل الGridView
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // عدد العناصر في الصف الواحد
                      childAspectRatio: 0.8, // نسبة أبعاد العنصر
                      crossAxisSpacing: 10.0, // المسافة بين العناصر عبر الصفوف
                      mainAxisSpacing: 8.0, // المسافة بين العناصر عبر الأعمدة
                    ),
                    itemCount: city.salesInfo.length, // عدد المندوبين
                    itemBuilder: (BuildContext context, int salesIndex) {
                      var salesRep = city.salesInfo[salesIndex];
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: Get.width * 0.08, // حجم الصورة
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: salesRep.image,
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0), // المسافة بين الصورة والنص
                            Expanded(
                              // استخدام Expanded لجعل الContainer يمتد لكامل الارتفاع المتاح
                                child: GestureDetector(
                                  onTap: () {
                                    controller.callPhone(salesRep.phone);
                                  },
                                  child: Container(
                                    width: double.infinity, // جعل العرض يمتد لكامل العرض المتاح
                                    color: AppColors.cbcColor,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(salesRep.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: Get.width * 0.03)),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(salesRep.phone,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: Get.width * 0.025,
                                                )),
                                            FaIcon(
                                              FontAwesomeIcons.phone,
                                              color: Colors.green,
                                              size: Get.width * 0.028,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }
}
