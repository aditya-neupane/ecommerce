import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';

class FirestoreServices {
  //get user data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  // get product according to category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('addded_by', isEqualTo: uid)
        .snapshots();
  }

  //delte documnet
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

//get all chahts messages
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }
}
