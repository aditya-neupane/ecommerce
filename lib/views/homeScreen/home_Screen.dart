import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/views/homeScreen/components/featured_button.dart';
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
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: whiteColor,
                hintText: serachAnything,
                hintStyle: TextStyle(color: textfieldGrey)),
          ),
        ),

        //swiper brands
        10.heightBox,
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
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
                            width: context.screenWidth * 0.40,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todayDeal : flashSale,
                          )),
                ),
                10.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: secondSlidersList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondSlidersList[index],
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
                      3,
                      (index) => homeButtons(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? topCategories
                                : index == 1
                                    ? brand
                                    : topSellers,
                          )),
                ),
                // featured categories
                20.heightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: featuredCategories.text
                      .color(darkFontGrey)
                      .size(18)
                      .fontFamily(semibold)
                      .make(),
                ),
                20.heightBox,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Column(
                              children: [
                                featuredButton(),
                                10.heightBox,
                                featuredButton(),
                              ],
                            )).toList(),
                  ),
                )
              ],
            ),
          ),
        )
      ])),
    );
  }
}
