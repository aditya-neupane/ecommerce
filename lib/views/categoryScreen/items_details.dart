import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/views/chat_screen/chat_screen.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemsDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return PopScope(
      onPopInvoked: (didPop) {
        controller.resetValues();
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishList(data.id, context);
                    } else {
                      controller.addToWishList(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    color: controller.isFav.value ? Colors.red : Colors.grey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        itemCount: data['p_images'].length,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_images'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),

                    10.heightBox,
                    //title and detail section
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),

                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),

                    10.heightBox,
                    data['p_price']
                        .toString()
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),

                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .color(darkFontGrey)
                                .make(),
                          ],
                        )),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(
                            () => const ChatScreen(),
                            arguments: [data['p_seller'], data['vendor_id']],
                          );
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),

                    //color section
                    20.heightBox,

                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    // data['p_color'].length,
                                    3,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Vx.randomPrimaryColor)
                                                //  (Color(data['p_color'][index]).withOpacity(1.0))
                                                .margin(EdgeInsetsDirectional
                                                    .symmetric(horizontal: 4))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                                visible: index ==
                                                    controller.colorIndex.value,
                                                child: Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        )),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //quantitiy row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateToatalPrice(
                                              int.parse(
                                                  data['p_price'].toString()));
                                        },
                                        icon: Icon(Icons.remove)),
                                    controller.quantity.value.text
                                        .color(darkFontGrey)
                                        .size(16)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                            int.parse(
                                                data['p_quantity'].toString()),
                                          );
                                          controller.calculateToatalPrice(
                                              int.parse(
                                                  data['p_price'].toString()));
                                        },
                                        icon: Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quantity']} available)"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //total row

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total: ".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //description section
                    10.heightBox,
                    "Description"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),

                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),
                    //button section
                    10.heightBox,
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetailButtonList.length,
                          (index) => ListTile(
                                title: itemDetailButtonList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: Icon(Icons.arrow_forward),
                              )),
                    ),
                    20.heightBox,

                    //producys you may like
                    productsYouMayLike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),

                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Laptop 4Gb/64gb"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$600"
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
                                    .padding(EdgeInsets.all(8))
                                    .make()),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: redColor,
                onPress: () {
                  controller.addToCart(
                      title: data['p_name'],
                      img: data['p_images'][0],
                      sellername: data['p_seller'],
                      // color: data['p_color'][controller.colorIndex.value],
                      qty: controller.quantity.value,
                      tprice: controller.totalPrice.value,
                      context: context);
                  VxToast.show(context, msg: "Added to cart");
                },
                textColor: whiteColor,
                title: "Add to cart",
              ),
            )
          ],
        ),
      ),
    );
  }
}
