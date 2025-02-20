import 'package:ecommerce/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/profile_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/auth_screen/login_screen.dart';
import 'package:ecommerce/views/profileScreen/components/details_card.dart';
import 'package:ecommerce/views/profileScreen/edit_profile_screen.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            }

            final data = snapshot.data!.docs[0];
            return SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red, Colors.redAccent],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: whiteColor),
                            onPressed: () {
                              controller.nameController.text = data['name'];
                              Get.to(() => EditProfileScreen(data: data));
                            },
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'profile',
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(75),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                child: data['imgUrl'] == ''
                                    ? Image.asset(imgProfile2,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover)
                                    : Image.network(data['imgUrl'],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          20.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .size(20)
                                    .make(),
                                5.heightBox,
                                "${data['email']}"
                                    .text
                                    .white
                                    .size(16)
                                    .make(),
                                10.heightBox,
                                OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: whiteColor),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signOut(context);
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  icon: const Icon(Icons.logout,
                                      color: Colors.white),
                                  label:
                                      logout.text.white.fontFamily(semibold).make(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    30.heightBox,
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(
                            count: data['cart_count'].toString(),
                            title: "in your cart",
                            width: context.screenWidth / 3.4,
                          ),
                          detailsCard(
                            count: data['wishlist_count'].toString(),
                            title: "in your wishlist",
                            width: context.screenWidth / 3.4,
                          ),
                          detailsCard(
                            count: data['orders_count'].toString(),
                            title: "your orders",
                            width: context.screenWidth / 3.4,
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.grey,
                            height: 20,
                          ),
                          itemCount: profileButtonList.length,
                          itemBuilder: (context, index) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                profileButtonIcon[index],
                                width: 22,
                                color: redColor,
                              ),
                            ),
                            title: profileButtonList[index]
                                .text
                                .fontFamily(bold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: darkFontGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
