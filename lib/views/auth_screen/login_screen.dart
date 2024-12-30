import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/widgets_common/applogo_widget.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:ecommerce/widgets_common/custom_textfeild.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            body: Center(
      child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Log into $appname".text.fontFamily(bold).size(18).white.make(),
          Column(
            children: [
              // customTextField(),
              // customTextField(),
            ],
          )
              .box
              .white
              .rounded
              .padding(EdgeInsets.all(16))
              .width(context.screenWidth - 70)
              .make(),
        ],
      ),
    )));
  }
}
