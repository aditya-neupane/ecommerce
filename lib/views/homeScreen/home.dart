import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controllers/home_controller.dart';
import 'package:ecommerce/views/cartScreen/cart_Screen.dart';
import 'package:ecommerce/views/categoryScreen/category_Screen.dart';
import 'package:ecommerce/views/homeScreen/home_Screen.dart';
import 'package:ecommerce/views/profileScreen/profile_Screen.dart';
import 'package:ecommerce/widgets_common/exit_dialg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 26),
          activeIcon: Icon(Icons.home, size: 26, color: redColor),
          label: home),
      BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined, size: 26),
          activeIcon: Icon(Icons.category, size: 26, color: redColor),
          label: categories),
      BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined, size: 26),
          activeIcon: Icon(Icons.shopping_cart, size: 26, color: redColor),
          label: cart),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, size: 26),
          activeIcon: Icon(Icons.person, size: 26, color: redColor),
          label: account),
    ];

    var navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            selectedItemColor: redColor,
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
