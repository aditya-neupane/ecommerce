import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/categoryScreen/items_details.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:ecommerce/widgets_common/loadind_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  final String? image;
  const CategoryDetails({super.key, required this.title, this.image});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        overlayImage: image,
        child: Scaffold(
          appBar: AppBar(
            title: title!.text.fontFamily(bold).white.make(),
          ),
          body: StreamBuilder(
            stream: FirestoreServices.getProducts(title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "No products found".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                return Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        image!,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ).box.roundedSM.clip(Clip.antiAlias).make(),
                      10.heightBox,
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                controller.subcat.length,
                                (index) => "${controller.subcat[index]}"
                                    .text
                                    .size(12)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .white
                                    .rounded
                                    .size(120, 60)
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .make())),
                      ),

                      //items container
                      20.heightBox,
                      Expanded(
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 250,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_images'][0],
                                      height: 160,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ).box.roundedSM.clip(Clip.antiAlias).make(),
                                    5.heightBox,
                                    "${data[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${data[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .roundedSM
                                    .outerShadowSm
                                    .padding(EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  controller.checkIfFav(data[index]);
                                  Get.to(
                                    () => ItemsDetails(
                                      title: "${data[index]['p_name']}",
                                      data: data[index],
                                    ),
                                  );
                                });
                              }))
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
