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
    // putproduct(category);
    // putAllProducts();
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

  static putproduct(String productNAme) {
    return firestore.collection(productsCollection).add({
      'p_category': productNAme,
      'p_color': [42949],
      'p_images': [
        'https://media.istockphoto.com/id/1324844508/photo/gorgeous-woman-wearing-beautiful-maxi-dress-posing-against-wall-with-a-wild-grape.jpg?s=612x612&w=0&k=20&c=BJrcuLt0m5Hm6zOhgO-E0TGqIxzWKdecgw1xcOu1aN4='
      ],
      'p_desc': 'some description',
      'p_name': 'some product',
      'p_price': 10,
      'p_quantity': 10,
      'p_rating': 10,
      'p_seller': 'some seller',
      'p_subcategory': 'some subcategory',
      'p_wishlist': [],
      'vendor_id': 'some vendorid',
    });
  }

  static putAllProducts() async {
    // Women's Clothing
    await firestore.collection(productsCollection).add({
      'p_category': "Women's Clothing",
      'p_color': [0xFF4A90E2, 0xFFF44336],
      'p_images': [
        'https://images.unsplash.com/photo-1539008835657-9e8e9680c956'
      ],
      'p_desc': 'Elegant floral maxi dress perfect for summer',
      'p_name': 'Summer Maxi Dress',
      'p_price': "89",
      'p_quantity': "50",
      'p_rating': "4.5",
      'p_seller': 'Fashion Boutique',
      'p_subcategory': 'Dresses',
      'p_wishlist': [],
      'vendor_id': 'fashion_boutique_1'
    });

    // Men Clothing
    await firestore.collection(productsCollection).add({
      'p_category': "Men Clothing and Fashion",
      'p_color': [0xFF000000, 0xFF333333],
      'p_images': [
        'https://images.unsplash.com/photo-1593030761757-71fae45fa0e7'
      ],
      'p_desc': 'Classic fit cotton business shirt',
      'p_name': 'Business Shirt',
      'p_price': "45",
      'p_quantity': "100",
      'p_rating': "4.2",
      'p_seller': 'MenStyle',
      'p_subcategory': 'Shirts',
      'p_wishlist': [],
      'vendor_id': 'menstyle_2'
    });

    // Computer Accessories
    await firestore.collection(productsCollection).add({
      'p_category': "Computer & Accessories",
      'p_color': [0xFF808080],
      'p_images': [
        'https://images.unsplash.com/photo-1527814050087-3793815479db'
      ],
      'p_desc': 'Wireless gaming mouse with RGB lighting',
      'p_name': 'Gaming Mouse',
      'p_price': "59",
      'p_quantity': "200",
      'p_rating': "4.7",
      'p_seller': 'TechGear',
      'p_subcategory': 'Peripherals',
      'p_wishlist': [],
      'vendor_id': 'techgear_3'
    });

    // Automobile
    await firestore.collection(productsCollection).add({
      'p_category': "Automobile",
      'p_color': [0xFFFF0000],
      'p_images': [
        'https://images.unsplash.com/photo-1610647752706-3bb12232b3ab'
      ],
      'p_desc': 'Premium car cleaning kit with microfiber cloths',
      'p_name': 'Car Cleaning Kit',
      'p_price': "35",
      'p_quantity': "75",
      'p_rating': "4.3",
      'p_seller': 'AutoCare',
      'p_subcategory': 'Car Care',
      'p_wishlist': [],
      'vendor_id': 'autocare_4'
    });

    // Kids Toys
    await firestore.collection(productsCollection).add({
      'p_category': "Kids Toys",
      'p_color': [0xFFFFEB3B, 0xFF4CAF50],
      'p_images': [
        'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1'
      ],
      'p_desc': 'Educational building blocks set for children',
      'p_name': 'Building Blocks Set',
      'p_price': "29",
      'p_quantity': "150",
      'p_rating': "4.8",
      'p_seller': 'ToyWorld',
      'p_subcategory': 'Educational Toys',
      'p_wishlist': [],
      'vendor_id': 'toyworld_5'
    });

    // Sports
    await firestore.collection(productsCollection).add({
      'p_category': "Sports",
      'p_color': [0xFF2196F3],
      'p_images': [
        'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2'
      ],
      'p_desc': 'Professional yoga mat with carrying strap',
      'p_name': 'Yoga Mat',
      'p_price': "25",
      'p_quantity': "100",
      'p_rating': "4.6",
      'p_seller': 'SportsFit',
      'p_subcategory': 'Yoga',
      'p_wishlist': [],
      'vendor_id': 'sportsfit_6'
    });

    // Jewelry
    await firestore.collection(productsCollection).add({
      'p_category': "Jewelry",
      'p_color': [0xFFFFD700],
      'p_images': [
        'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338'
      ],
      'p_desc': 'Sterling silver necklace with pendant',
      'p_name': 'Silver Necklace',
      'p_price': "99",
      'p_quantity': "30",
      'p_rating': "4.9",
      'p_seller': 'JewelCraft',
      'p_subcategory': 'Necklaces',
      'p_wishlist': [],
      'vendor_id': 'jewelcraft_7'
    });

    // Cell Phones
    await firestore.collection(productsCollection).add({
      'p_category': "Cell Phones",
      'p_color': [0xFF9E9E9E],
      'p_images': [
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'
      ],
      'p_desc': 'Premium smartphone case with card holder',
      'p_name': 'Phone Case',
      'p_price': "19",
      'p_quantity': "200",
      'p_rating': "4.4",
      'p_seller': 'MobileGear',
      'p_subcategory': 'Accessories',
      'p_wishlist': [],
      'vendor_id': 'mobilegear_8'
    });

    // Furniture
    await firestore.collection(productsCollection).add({
      'p_category': "Furniture",
      'p_color': [0xFF795548],
      'p_images': ['https://images.unsplash.com/photo-1555041469-a586c61ea9bc'],
      'p_desc': 'Modern wooden coffee table',
      'p_name': 'Coffee Table',
      'p_price': "199",
      'p_quantity': "20",
      'p_rating': "4.7",
      'p_seller': 'HomeDecor',
      'p_subcategory': 'Tables',
      'p_wishlist': [],
      'vendor_id': 'homedecor_9'
    });
  }
}
