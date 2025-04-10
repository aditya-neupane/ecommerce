import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/cartScreen/shipping_screen.dart';
import 'package:ecommerce/widgets_common/loadind_indicator.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: "Shopping Cart"
            .text
            .size(22)
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: darkFontGrey.withValues(alpha: 0.7),
                  ),
                  20.heightBox,
                  "Your cart is empty".text.size(18).color(darkFontGrey).make(),
                ],
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 0.5,
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "${data[index]['img']}",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: "${data[index]['title']}"
                                    .text
                                    .size(16)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Quantity: ${data[index]['qty']}"
                                        .text
                                        .color(
                                            darkFontGrey.withValues(alpha: 0.7))
                                        .make(),
                                    5.heightBox,
                                    "${data[index]['tPrice']}"
                                        .numCurrency
                                        .text
                                        .size(16)
                                        .fontFamily(semibold)
                                        .color(redColor)
                                        .make(),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      color: redColor),
                                  onPressed: () {
                                    FirestoreServices.deleteDocument(
                                        data[index].id);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: lightGolden,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      width: context.screenWidth - 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price"
                              .text
                              .size(18)
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "${controller.totalP.value}"
                                .numCurrency
                                .text
                                .size(20)
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    )
                  ],
                ),
                child: ourButton(
                  color: redColor,
                  onPress: () {
                    Get.to(() => const ShippingDetails());
                  },
                  textColor: whiteColor,
                  title: "Proceed to checkout",
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
