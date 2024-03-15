import 'package:ecommerceapp/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildNavButton(
    iconAsset, String label, int index, ProductController controller) {
  return Row(
    children: [
      IconButton(
        icon: iconAsset,
        // icon: Image.asset(
        //   iconAsset,
        // ),
        color: controller.currentnavIndex.value == index
            ? Colors.black
            : Colors.grey,
        onPressed: () {
          controller.currentnavIndex.value = index;
        },
      ),
      GestureDetector(
        onTap: () {
          controller.currentnavIndex.value = index;
        },
        child: Text(
          label,
          style: TextStyle(
            color: controller.currentnavIndex.value == index
                ? Colors.black
                : Colors.grey,
          ),
        ),
      ),
    ],
  );
}
