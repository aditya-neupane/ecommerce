import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/lists.dart';
import 'package:ecommerce/views/homeScreen/components/featured_button.dart';
import 'package:ecommerce/widgets_common/home_buttons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          width: context.screenWidth,
          height: context.screenHeight,
          child: Column(children: [
            // Search Bar
            Container(
              alignment: Alignment.center,
              height: 60,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: serachAnything,
                  hintStyle: const TextStyle(color: textfieldGrey),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Swiper Banners
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Handle banner tap
                            },
                            child: Image.asset(
                              slidersList[index],
                              fit: BoxFit.cover,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .shadow
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make(),
                          );
                        }),

                    15.heightBox,
                    // Deals Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => GestureDetector(
                                onTap: () {
                                  // Handle deal button tap
                                },
                                child: homeButtons(
                                  height: context.screenHeight * 0.15,
                                  width: context.screenWidth * 0.40,
                                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                  title: index == 0 ? todayDeal : flashSale,
                                ),
                              )),
                    ),

                    10.heightBox,
                    // Second Swiper
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSlidersList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Handle second banner tap
                            },
                            child: Image.asset(
                              secondSlidersList[index],
                              fit: BoxFit.cover,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .shadow
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make(),
                          );
                        }),

                    10.heightBox,
                    // Category Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => GestureDetector(
                                onTap: () {
                                  // Handle category tap
                                },
                                child: homeButtons(
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
                                ),
                              )),
                    ),

                    20.heightBox,
                    // Featured Categories
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    ),

                    20.heightBox,
                    // Featured Buttons
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Handle featured item tap
                                      },
                                      child: Column(
                                        children: [
                                          featuredButton(
                                              icon: featuredImages1[index],
                                              title: featuredTitles1[index]),
                                          10.heightBox,
                                          featuredButton(
                                              icon: featuredImages2[index],
                                              title: featuredTitles2[index]),
                                        ],
                                      ),
                                    )
                                  ],
                                )).toList(),
                      ),
                    ),

                    20.heightBox,
                    // Featured Products
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featureedProduct.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  6,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          // Handle product tap
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              imgP1,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                            10.heightBox,
                                            "Laptop 4Gb/64gb"
                                                .text
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .make(),
                                            5.heightBox,
                                            "\$600"
                                                .text
                                                .color(redColor)
                                                .fontFamily(bold)
                                                .size(16)
                                                .make(),
                                          ],
                                        )
                                            .box
                                            .white
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .rounded
                                            .shadow
                                            .padding(const EdgeInsets.all(12))
                                            .make(),
                                      )),
                            ),
                          ),
                        ],
                      ),
                    ),

                    20.heightBox,
                    // Third Swiper
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSlidersList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Handle third banner tap
                            },
                            child: Image.asset(
                              secondSlidersList[index],
                              fit: BoxFit.cover,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .shadow
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make(),
                          );
                        }),

                    20.heightBox,
                    // All Products Grid
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                mainAxisExtent: 300),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Handle grid product tap
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  imgP5,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                "Laptop 4Gb/64gb"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                5.heightBox,
                                "\$600"
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .rounded
                                .shadow
                                .padding(const EdgeInsets.all(12))
                                .make(),
                          );
                        }),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
