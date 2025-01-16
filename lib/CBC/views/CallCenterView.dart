import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Help.dart';

import '../../res/colors.dart';
class CallCenterView extends StatelessWidget {
   CallCenterView({super.key});
   final HelpController controller = Get.put(HelpController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: ()async{
          controller.fetchCallCenter();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Center(
              child: SizedBox(
                height: Get.width * 0.3,
                width: Get.width * 0.8,
                child: Image.asset('assets/images/callcenter.png' , fit: BoxFit.fill,),
              ),
            ),
            Container(
              height: Get.width * 0.0003,
              width: Get.width * 0.9,
              color: Colors.black,
            ),
            SizedBox(
              height: Get.width * 0.05,
            ),
            Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.05 , end: Get.width * 0.05),
              child: Text('134'.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.039
                ),),
            ),
            SizedBox(
              height: Get.width * 0.05,
            ),
            Padding(padding: EdgeInsetsDirectional.only(start: Get.width * 0.05 , end: Get.width * 0.05),
              child: Text('135'.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.025
                ),
              ),
            ),
            SizedBox(
              height: Get.width * 0.8,
              child: GetBuilder<HelpController>(builder: (builder){
                if(!builder.isLoadingCallCenter.value){
                  if(builder.callCenterList.isNotEmpty){
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: PageScrollPhysics(),
                      padding: EdgeInsetsDirectional.only(start: Get.width * 0.02,end: Get.width * 0.02),
                      itemCount: builder.callCenterList.length, // عدد العناصر في القائمة
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // لون خلفية الـ Container
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5), // لون الظل مع شفافية
                                  spreadRadius: 0, // إزالة انتشار الظل
                                  blurRadius: 10, // زيادة تمويه الظل لجعله أكثر نعومة
                                  offset: const Offset(0, 5), // الإزاحة فقط في الاتجاه العمودي
                                ),
                              ],
                            ),
                            child: Text(
                              '${'131'.tr } ${builder.callCenterList[index].city} : ${builder.callCenterList[index].phone}',
                              style: TextStyle(
                                  fontSize: Get.width * 0.028,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          trailing: Wrap(
                            spacing: 12, // space between two icons
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(Get.width * 0.01),
                                  decoration: BoxDecoration(
                                      color: AppColors.cbcColor,
                                      border: Border.all(
                                        color: AppColors.cbcColor,
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))
                                  ),
                                  width: Get.width * 0.08,
                                  height: Get.width * 0.06,
                                  child: Center(
                                    child: FaIcon(FontAwesomeIcons.whatsapp , size: Get.width * 0.035, color: Colors.white,),
                                  ),
                                ),
                                onTap: (){
                                  controller.launchWhatsAppUri(builder.callCenterList[index].phone);
                                },
                              ),
                              GestureDetector(
                                onTap: (){
                                  controller.callPhone(builder.callCenterList[index].phone);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(Get.width * 0.01),
                                  decoration: BoxDecoration(
                                      color: AppColors.cbcColor,
                                      border: Border.all(
                                        color: AppColors.cbcColor,
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))
                                  ),
                                  width: Get.width * 0.08,
                                  height: Get.width * 0.06,
                                  child: Center(
                                    child: FaIcon(FontAwesomeIcons.phone , size: Get.width * 0.035, color: Colors.white,),
                                  ),
                                ),
                              )

                            ],
                          ),
                        );

                      },
                    );
                  }else{
                    return Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('20'.tr),
                        SizedBox(width: Get.width * 0.02,),
                        FaIcon(FontAwesomeIcons.faceSadTear)
                      ],
                    ),);
                  }
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: Get.width * 0.08 , end: Get.width * 0.08),
              child: Text('136'.tr,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Get.width * 0.06,
                ),
              ) ,
            )
          ],
        ),
      ),
    );
  }
}
