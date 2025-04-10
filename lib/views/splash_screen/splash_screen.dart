import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/views/auth_screen/login_screen.dart';
import 'package:ecommerce/views/homeScreen/home.dart';
import 'package:ecommerce/views/homeScreen/homepage_screen.dart';
import 'package:ecommerce/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //cretaing a method to change screen
  changeScreen() async {
    // Already done this in authentatelogin screen see/check there.
    await Future.delayed(Duration(seconds: 3));
    // Future.delayed(Duration(seconds: 3), () {
    //   //using get X
    //   // Get.to(() => const LoginScreen());

    //   auth.authStateChanges().listen((User? user) {
    //     if (user == null && mounted) {
    //       Get.offAll(() => LoginScreen());
    //     } else {
    //       Get.offAll(() => const Home());
    //     }
    //   });
    // });
    Get.offAll(() => const AuthenticatePage());
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(), //ask
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
