import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controllers/chats_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/chat_screen/components/sender_bubble.dart';
import 'package:ecommerce/widgets_common/loadind_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Title".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: loadingIndicator(),
                    )
                  : Expanded(
                      child: StreamBuilder(
                        stream: FirestoreServices.getChatMessages(
                            controller.chatDocId.toString()),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: "Send a message"
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          } else {
                            return ListView(
                                // children: snapshot.data!.docs
                                //     .mapIndexed((currentValue, index)),
                                );
                          }
                        },
                      ),
                    ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: InputDecoration(
                    hintText: "Enter your message",
                    hintStyle: TextStyle(color: darkFontGrey),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: textfieldGrey)),
                    focusedBorder: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: Icon(Icons.send, color: redColor)),
              ],
            )
                .box
                .height(80)
                .padding(EdgeInsets.all(12))
                .margin(EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}
