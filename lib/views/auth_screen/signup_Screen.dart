import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/views/auth_screen/login_screen.dart';
import 'package:ecommerce/views/homeScreen/home.dart';
import 'package:ecommerce/widgets_common/applogo_widget.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:ecommerce/widgets_common/custom_textfeild.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordReTypeController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   nameController.text = name;
  //   emailController.text = email;
  //   passwordController.text = password;
  //   PasswordReTypeController.text = retypePassword;
  // }
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
                  "Join the $appname"
                      .text
                      .fontFamily(bold)
                      .size(18)
                      .white
                      .make(),
                  15.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        customTextField(
                            hint: nameHint,
                            title: name,
                            controller: nameController,
                            isPAss: false),
                        customTextField(
                            hint: emailHint,
                            title: email,
                            controller: emailController,
                            isPAss: false),
                        customTextField(
                            hint: passwordHint,
                            title: password,
                            controller: passwordController,
                            isPAss: true),
                        customTextField(
                            hint: passwordHint,
                            title: retypePassword,
                            controller: passwordReTypeController,
                            isPAss: true),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: forgetPass.text.make())),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: redColor,
                                checkColor: whiteColor,
                                value: isCheck,
                                onChanged: (newValue) {
                                  setState(() {
                                    isCheck = newValue;
                                  });
                                }),
                            10.widthBox,
                            Expanded(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )),
                                TextSpan(
                                    text: termAndCond,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    )),
                                TextSpan(
                                    text: " &",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ))
                              ])),
                            )
                          ],
                        ),
                        5.heightBox,
                        controller.isLoading.value
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : ourButton(
                                color: isCheck == true ? redColor : fontGrey,
                                title: signUp,
                                textColor: whiteColor,
                                onPress: () async {
                                  if (isCheck != false) {
                                    controller.isLoading.value = true;
                                    try {
                                      await controller
                                          .signupMethod(emailController.text,
                                              passwordController.text, context)
                                          .then((value) {
                                        return controller.storeUserData(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                        );
                                      }).then((value) {
                                        VxToast.show(context, msg: loggedIn);
                                        Get.offAll(() => const LoginScreen());
                                      });
                                    } catch (e) {
                                      auth.signOut();
                                      VxToast.show(context, msg: e.toString());
                                      controller.isLoading.value = false;
                                    }
                                  }
                                },
                              ).box.width(context.screenWidth - 50).make(),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            alreadyHaveAccount.text.color(fontGrey).make(),
                            login.text.color(redColor).make().onTap(() {
                              Get.back();
                            }),
                          ],
                        )
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(EdgeInsets.all(16))
                        .width(context.screenWidth - 70)
                        .shadowSm
                        .make(),
                  ),
                ],
              ),
            )));
  }
}
