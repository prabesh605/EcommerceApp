import 'package:ecommerceapp/Views/Category_screen/item_details.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title.text.make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 250,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8),
          itemBuilder: ((context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    fashion1,
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                "Dorothy Perkhins".text.size(12).color(Colors.black45).make(),
                "Morning Dress".text.size(16).bold.color(Colors.black87).make(),
                "Rs. 2000".text.size(16).color(Colors.black87).make(),
              ],
            )
                .box
                .white
                .margin(const EdgeInsets.symmetric(horizontal: 4))
                .roundedSM
                .outerShadowSm
                .make()
                .onTap(() {
              Get.to(
                () => const ItemDetails(
                  title: "New Item",
                ),
              );
            });
          }),
        ),
      ),
    );
  }
}
