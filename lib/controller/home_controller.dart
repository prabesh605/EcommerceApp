import 'package:ecommerceapp/consts/firebase_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var username = '';

  //search controller
  var searchController = TextEditingController();

  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }
}
