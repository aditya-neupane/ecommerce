import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget featuredButton() {
  return Row(
    children: [
      Image.asset(
        imgS1,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      womenDress.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .padding(EdgeInsets.all(4))
      .white
      .outerShadowSm
      .make();
}
