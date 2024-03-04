import 'package:ecommerceapp/Views/Category_screen/category_details.dart';
import 'package:ecommerceapp/consts/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MenCategory extends StatelessWidget {
  const MenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: menCategoryImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => CategoryDetails(
                              title: menCategoryTitles[index],
                            ));
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              menCategoryImages[index],
                              height: 150,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          menCategoryTitles[index].text.size(20).normal.make()
                        ],
                      )
                          .box
                          .white
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .roundedSM
                          .outerShadowSm
                          .make(),
                    );
                  }))
            ],
          )),
    );
  }
}
