import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/views/profileScreen/components/details_card.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: SafeArea(
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
                ).onTap(() {}),
              ),
            ),

            //users details section
            Row(
              children: [
                Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make(),
                10.widthBox,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Dummy user".text.fontFamily(semibold).white.make(),
                    "Customer@email.com".text.white.make(),
                  ],
                )),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: whiteColor),
                    ),
                    onPressed: () {},
                    child: logout.text.white.fontFamily(semibold).make())
              ],
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                detailsCard(
                    count: "00",
                    title: "in your cart",
                    width: context.screenWidth / 3.4),
                detailsCard(
                    count: "32",
                    title: "in your wishlist",
                    width: context.screenWidth / 3.4),
                detailsCard(
                    count: "675",
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
        )),
      ),
    );
  }
}
