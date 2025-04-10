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
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    colors: [Color(0xFFE53935), Color(0xFFEF5350)],
                  ),
                ),
                child: Column(
                  children: [
                    // App Bar
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(51),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit, color: whiteColor),
                              onPressed: () {
                                controller.nameController.text = data['name'];
                                Get.to(() => EditProfileScreen(data: data));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Profile Info
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(38),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withAlpha(51)),
                      ),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'profile',
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(75),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withAlpha(230),
                                    Colors.white.withAlpha(102),
                                  ],
                                ),
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
                                    .size(24)
                                    .make(),
                                10.heightBox,
                                "${data['email']}".text.white.size(16).make(),
                                15.heightBox,
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: redColor,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signOut(context);
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  icon: const Icon(Icons.logout, size: 20),
                                  label: Text(
                                    logout,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    30.heightBox,
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(38),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withAlpha(51)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: detailsCard(
                              count: data['cart_count'].toString(),
                              title: "Cart",
                              width: context.screenWidth / 3.8,
                            ),
                          ),
                          Expanded(
                            child: detailsCard(
                              count: data['wishlist_count'].toString(),
                              title: "Wishlist",
                              width: context.screenWidth / 3.8,
                            ),
                          ),
                          Expanded(
                            child: detailsCard(
                              count: data['orders_count'].toString(),
                              title: "Orders",
                              width: context.screenWidth / 3.8,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(26),
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.black12,
                            height: 32,
                          ),
                          itemCount: profileButtonList.length,
                          itemBuilder: (context, index) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: redColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset(
                                profileButtonIcon[index],
                                width: 24,
                                height: 24,
                                color: redColor,
                              ),
                            ),
                            title: profileButtonList[index]
                                .text
                                .fontFamily(bold)
                                .color(darkFontGrey)
                                .size(16)
                                .make(),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
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
