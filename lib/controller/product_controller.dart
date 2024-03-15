import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ecommerceapp/consts/firebase_consts.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController {
  var currentnavIndex = 0.obs;
  var counter = 1.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  calculateTotalPrice(price) {
    totalPrice.value = price * counter.value;
  }

  increment() {
    if (counter < 9) {
      counter.value++;
    }
  }

  decrement() {
    if (counter > 1) {
      counter.value--;
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  resetValues() {
    counter = 1.obs;
    colorIndex = 0.obs;

    totalPrice = 0.obs;
  }

  addToCart(
      {title, img, sellername, color, qty, tprice, context, vendorID}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'tprice': tprice,
      'added_by': currentUser!.uid,
      'vendor_id': vendorID,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Remove from wishlist");
  }

  checkIfFav(data) {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
