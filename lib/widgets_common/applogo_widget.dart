import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget applogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(EdgeInsets.all(8))
      .rounded
      .make(); //ask
}
