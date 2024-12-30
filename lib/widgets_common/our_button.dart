import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPress, color, textColor, title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: EdgeInsets.all(12),
    ),
    onPressed: () {
      onPress();
    },
    child: title.text.color(textColor).fontfamily(bold).make(),
  );
}