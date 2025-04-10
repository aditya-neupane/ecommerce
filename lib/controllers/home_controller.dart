import 'package:ecommerce/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var username = '';

  getUsername() async {
    print("username: ${currentUser?.uid}");
    var n = await firestore //addd
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser?.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }
}
