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
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          "Shipping Information",
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: darkFontGrey),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Delivery Details",
                style: TextStyle(
                  color: darkFontGrey,
                  fontSize: 18,
                  fontFamily: semibold,
                ),
              ),
              20.heightBox,
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    customTextField(
                        hint: "Enter your full address",
                        isPAss: false,
                        title: "Delivery Address"),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: customTextField(
                              hint: "Enter city", isPAss: false, title: "City"),
                        ),
                        10.widthBox,
                        Expanded(
                          child: customTextField(
                              hint: "Enter state",
                              isPAss: false,
                              title: "State"),
                        ),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: customTextField(
                              hint: "Enter postal code",
                              isPAss: false,
                              title: "Postal Code"),
                        ),
                        10.widthBox,
                        Expanded(
                          child: customTextField(
                              hint: "Enter phone number",
                              isPAss: false,
                              title: "Phone"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: ourButton(
          title: "Continue to Payment",
          onPress: () {},
          color: redColor,
          textColor: whiteColor,
        ),
      ),
    );
  }
}
