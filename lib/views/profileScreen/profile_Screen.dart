import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/profile_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/auth_screen/login_screen.dart';
import 'package:ecommerce/views/profileScreen/components/details_card.dart';
import 'package:ecommerce/views/profileScreen/edit_profile_screen.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snaphot) {
              if (!snaphot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                var data = snaphot.data!.docs[0];

                return SafeArea(
                    child: Column(
                  children: [
                    //edit profile button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: const Icon(
                          Icons.edit,
                          color: whiteColor,
                        ).onTap(() {
                          controller.nameController.text = data['name'];

                          Get.to(() => EditProfileScreen(data: data));
                        }),
                      ),
                    ),

                    //users details section
                    Row(
                      children: [
                        data['imgUrl'] == ''
                            ? Image.asset(imgProfile2,
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(data['imgUrl'],
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            "${data['email']}".text.white.make(),
                          ],
                        )),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: whiteColor),
                            ),
                            onPressed: () async {
                              await Get.put(AuthController()).signOut(context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child:
                                logout.text.white.fontFamily(semibold).make())
                      ],
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detailsCard(
                            count: data['cart_count'],
                            title: "in your cart",
                            width: context.screenWidth / 3.4),
                        detailsCard(
                            count: data['wishlist_count'],
                            title: "in your wishlist",
                            width: context.screenWidth / 3.4),
                        detailsCard(
                            count: data['order_count'],
                            title: "your orders",
                            width: context.screenWidth / 3.4),
                      ],
                    ),

                    //buttons section

                    ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: lightGrey,
                              );
                            },
                            itemCount: profileButtonList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.asset(
                                  profileButtonIcon[index],
                                  width: 22,
                                ),
                                title: profileButtonList[index]
                                    .text
                                    .fontFamily(bold)
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            })
                        .box
                        .white
                        .rounded
                        .shadowSm
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .margin(EdgeInsets.all(12))
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ));
              }
            }),
      ),
    );
  }
}
