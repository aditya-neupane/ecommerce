import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/widgets_common/custom_textfeild.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            title: "Continue",
            onPress: () {},
            color: redColor,
            textColor: whiteColor),
      ),
      body: Column(
        children: [
          customTextField(hint: "Address", isPAss: false, title: "Address"),
          customTextField(hint: "City", isPAss: false, title: "City"),
          customTextField(hint: "State", isPAss: false, title: "State"),
          customTextField(
              hint: "Postal Code", isPAss: false, title: "Postal Code"),
          customTextField(hint: "Phone", isPAss: false, title: "Phone"),
        ],
      ),
    );
  }
}
 