import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/views/auth_screen/signup_Screen.dart';
import 'package:ecommerce/views/homeScreen/home.dart';
import 'package:ecommerce/widgets_common/applogo_widget.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:ecommerce/widgets_common/custom_textfeild.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "Log into $appname"
                      .text
                      .fontFamily(bold)
                      .size(18)
                      .white
                      .make(),
                  15.heightBox,
                  Column(
                    children: [
                      customTextField(hint: emailHint, title: email),
                      customTextField(hint: passwordHint, title: password),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: forgetPass.text.make())),
                      5.heightBox,
                      ourButton(
                          color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () {
                            Get.to(() => Home());
                          }).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      ourButton(
                          color: lightGolden,
                          title: signUp,
                          textColor: redColor,
                          onPress: () {
                            Get.to(() => SignupScreen());
                          }).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      loginWith.text.color(fontGrey).make(),
                      5.heightBox,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: lightGrey,
                                      radius: 25,
                                      child: Image.asset(
                                        socilaIconList[index],
                                        width: 30,
                                      ),
                                    ),
                                  ))),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ],
              ),
            )));
  }
}
