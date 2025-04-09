import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  //text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  //login method
  Future<UserCredential?> loginMethod(context) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod(email, password, context) async {
    UserCredential? userCredential;
    if (!email.toString().contains(RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$'))) {
      return userCredential;
    }

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method
  void storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imgUrl':
          'https://fakeimg.pl/600x400?text=Sample+image', // TODO: implement image upload in future.
      'id': currentUser!.uid,
      'cart_count': 0,
      'wishlist_count': 0,
      'orders_count': 0,
    });
  }

  //signout method
  Future<void> signOut(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
