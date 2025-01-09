import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/images.dart';
import 'package:flutter/material.dart';

Widget homeButtons({width, height, icon, title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icTodaysDeal,
        width: 26,
      ),
      10.heightBox,
      todayDeal.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.rounded.white.size(width, height).make();
}
