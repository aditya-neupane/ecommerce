import 'package:ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget bgWidget({Widget? child, String? overlayImage}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imgBackground),
        fit: BoxFit.fill,
      ),
    ),
    child: Stack(
      children: [
        if (overlayImage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(overlayImage),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        child ?? Container(),
      ],
    ),
  );
}
