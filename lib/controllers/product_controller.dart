import 'dart:math';

import 'package:ecommerce/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subCat = [];
  getSubCategories(title) async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    print("lenght" + s.length.toString());
    for (var e in s[0].subcategories) {
      subCat.add(e);
    }
  }
}
