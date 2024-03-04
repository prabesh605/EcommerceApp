import 'package:ecommerceapp/Views/Category_screen/category_controller/category_controller.dart';
import 'package:ecommerceapp/Views/Category_screen/categorytype/baby_screen.dart';
import 'package:ecommerceapp/Views/Category_screen/categorytype/men_screen.dart';
import 'package:ecommerceapp/Views/Category_screen/categorytype/women_screen.dart';
import 'package:ecommerceapp/Views/Category_screen/components/buildnva_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CategoryController());
    var navScreens = [
      const WomanCategory(),
      const MenCategory(),
      const BabyCategory(),
    ];

    // Define your navigation items

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Categories".text.make(),
          backgroundColor: const Color.fromARGB(255, 245, 221, 229),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              // Customize background color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavButton(
                          const Icon(Icons.woman), 'Women', 0, controller)
                      .box
                      .roundedSM
                      .size(120, 50)
                      .color(Colors.grey.shade200)
                      .shadowSm
                      .make(),
                  buildNavButton(const Icon(Icons.man), 'Man', 1, controller)
                      .box
                      .roundedSM
                      .size(120, 50)
                      .color(Colors.grey.shade200)
                      .shadowSm
                      .make(),
                  buildNavButton(
                          const Icon(Icons.bedroom_baby), 'Baby', 2, controller)
                      .box
                      .roundedSM
                      .size(120, 50)
                      .color(Colors.grey.shade200)
                      .shadowSm
                      .make(),
                ],
              ),
            ),
            Expanded(
              child: navScreens.elementAt(controller.currentnavIndex.value),
            ),
          ],
        ),
      ),
    );
  }
}
