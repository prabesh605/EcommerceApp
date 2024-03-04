import 'package:get/get.dart';

class CategoryController extends GetxController {
  var currentnavIndex = 0.obs;
  var counter = 1.obs;

  void increment() {
    if (counter < 9) {
      counter++;
    }
  }

  void decrement() {
    if (counter > 1) {
      counter--;
    }
  }
}
