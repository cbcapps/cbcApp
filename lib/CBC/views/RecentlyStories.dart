import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/controllers/Home_controller.dart';
import 'package:ui_ecommerce/CBC/views/StorePage.dart';
import '../../res/colors.dart';
class RecentlyStories extends StatelessWidget {
  RecentlyStories({super.key});
  final Chome_controller controller = Get.put(Chome_controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: AppColors.cbcColor,
        centerTitle: true,
        title: Text('89'.tr ,style: TextStyle(
            color: Colors.white,
            fontSize: Get.width * 0.04,
            fontWeight: FontWeight.bold
        ),),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          controller.fetchRecently();

        },
        child: GetBuilder<Chome_controller>(builder: (builder){
          if(!builder.isLoadingRecently.value){
            if(builder.recentlyList.isNotEmpty){
              return Container(
                height: Get.height,
                width: Get.width,
                margin: EdgeInsets.only(bottom: Get.height * 0.02),
                color: Colors.white,
                child: stories(),
              );
            }else{
              print('not data');
              return Center(
                child: Text(
                    '${'20'.tr}'
                ),
              );
            }

          }else{
            return Center(child: SpinKitWave(
              color: AppColors.cbcColor,
              size: Get.width * 0.1,
            ),);
          }
        }),
      ),
    );
  }
  stories(){
    return GridView.builder(
      padding: EdgeInsets.only(left: Get.height * 0.01, right: Get.height * 0.01, top: Get.height * 0.01 ),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1.1,
      ),
      itemCount: controller.recentlyList.length,
      itemBuilder: (BuildContext context, int index) {
        final Item = controller.recentlyList[index];
        return DiscountItem(Item.image, Item.store, Item.storeId , Item.discount);
      },
    );
  }
  DiscountItem(String url , String label  , int id , String discount) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>StorePage() , arguments: [{"id" : id}]);
        //Get.toNamed('/products' , arguments: [{'id':id}]);
      },
      child: Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.01,end: Get.height * 0.01),
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(Get.height * 0.01),
          width: Get.height * 0.25,
          decoration: BoxDecoration(
              color :Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                height: Get.height * 0.08,
                width: Get.height * 0.08,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45.0),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.008,),
             Center(
               child:  SizedBox(
                 child: Text(label,
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(
                         fontSize: Get.height * 0.013
                     )),),
             ),
              SizedBox(height: Get.height * 0.003,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text('95'.tr ,  overflow: TextOverflow.ellipsis,),
                  Text(' ${discount} ',  overflow: TextOverflow.ellipsis,style: TextStyle(
                      color: AppColors.cbcRed,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.height * 0.018
                  ),),
                ],
              )
            ],
          ),
        )
      ),
    );
  }


}
