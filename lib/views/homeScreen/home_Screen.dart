import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/widgets_common/home_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(children: [
        Container(
          alignment: Alignment.center,
          height: 60,
          color: lightGrey,
          child: TextField(
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: whiteColor,
                hintText: serachAnything,
                hintStyle: TextStyle(color: textfieldGrey)),
          ),
        ),

        //swiper brands
        VxSwiper.builder(
            aspectRatio: 16 / 9,
            autoPlay: true,
            height: 150,
            enlargeCenterPage: true,
            itemCount: slidersList.length,
            itemBuilder: (context, index) {
              return Image.asset(
                slidersList[index],
                fit: BoxFit.fill,
              )
                  .box
                  .rounded
                  .clip(Clip.antiAlias)
                  .margin(EdgeInsets.symmetric(horizontal: 8))
                  .make();
            }),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              2,
              (index) => homeButtons(
                    height: context.screenHeight * 0.15,
                    width: context.screenWidth / 0.2,
                    icon: index == 0 ? icTodaysDeal : icFlashDeal,
                    title: index == 0 ? todayDeal : flashSale,
                  )),
        )
      ])),
    );
  }
}
