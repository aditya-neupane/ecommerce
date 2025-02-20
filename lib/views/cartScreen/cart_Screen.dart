import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/widgets_common/loadind_indicator.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No items in cart".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network("${data[index]['img']}"),
                        title:
                            "${data[index]['title']}  (x${data[index]['qty']})"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                        subtitle: "${data[index]['tPrice']}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                        trailing: Icon(Icons.delete, color: redColor).onTap(() {
                          FirestoreServices.deleteDocument(data[index].id);
                        }),
                      );
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(12))
                      .color(lightGolden)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                        color: redColor,
                        onPress: () {},
                        textColor: whiteColor,
                        title: "Proceed to checkout",
                      )),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
