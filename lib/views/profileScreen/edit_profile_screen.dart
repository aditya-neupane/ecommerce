import 'dart:io';

import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controllers/profile_controller.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:ecommerce/widgets_common/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: data['imgUrl'] == '' &&
                                  controller.profileImgPath.isEmpty
                              ? Image.asset(imgProfile2,
                                  width: 120, fit: BoxFit.cover)
                              : data['imgUrl'] != '' &&
                                      controller.profileImgPath.isEmpty
                                  ? Image.network(data['imgUrl'],
                                      width: 120, fit: BoxFit.cover)
                                  : Image.file(
                                      File(controller.profileImgPath.value),
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: redColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () => controller.changeImage(context),
                      ),
                    ),
                  ],
                ),
                30.heightBox,
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      customTextField(
                        controller: controller.nameController,
                        hint: nameHint,
                        title: name,
                        isPAss: false,
                      ),
                      20.heightBox,
                      customTextField(
                        controller: controller.oldpassController,
                        hint: passwordHint,
                        title: oldpass,
                        isPAss: true,
                      ),
                      20.heightBox,
                      customTextField(
                        controller: controller.newpassController,
                        hint: passwordHint,
                        title: newpass,
                        isPAss: true,
                      ),
                      30.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : SizedBox(
                              width: context.screenWidth - 60,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: redColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  controller.isLoading(true);

                                  if (controller.profileImgPath.value.isEmpty) {
                                    await controller.uploadProfileImage();
                                  } else {
                                    controller.profileImageLink =
                                        data['imgUrl'];
                                  }

                                  if (context.mounted &&
                                      data['password'] ==
                                          controller.oldpassController.text) {
                                    controller.changeAuthPassword(
                                      email: data['email'],
                                      newpassword:
                                          controller.oldpassController.text,
                                      password:
                                          controller.newpassController.text,
                                    );
                                    await controller.updateprofile(
                                      imgUrl: controller.profileImageLink,
                                      name: controller.nameController.text,
                                      passwword:
                                          controller.newpassController.text,
                                    );
                                    if (context.mounted) {
                                      VxToast.show(context,
                                          msg: "Profile updated successfully");
                                    }
                                  } else if (context.mounted) {
                                    VxToast.show(context,
                                        msg: "Old password is incorrect");
                                    controller.isLoading(false);
                                  }
                                },
                                child: Text(
                                  "Save Changes",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
