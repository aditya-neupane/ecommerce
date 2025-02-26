import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget senderBubble() {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: redColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20)),
    ),
    child: Column(
      children: [
        "Message Here...".text.white.size(16).make(),
        10.heightBox,
        " 11:11 pm".text.color(whiteColor.withOpacity(0.5)).make()
      ],
    ),
  );
}
