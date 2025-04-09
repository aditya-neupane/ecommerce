import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/firebase_consts.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subcat = [];

  var isFav = false.obs;
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategories) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    // colorIndex = index;
  }
  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateToatalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellername, color, qty, tprice, context}) async {
    await firestore.collection(cartCollection).doc().set({
      "title": title,
      "img": img,
      "sellername": sellername,
      "color": color,
      "qty": qty,
      "tPrice": tprice,
      "addded_by": currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    // colorIndex.value = 0;
  }

  addToWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(false);

    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav.value = true;
    } else {
      isFav.value = false;
    }
  }
}
