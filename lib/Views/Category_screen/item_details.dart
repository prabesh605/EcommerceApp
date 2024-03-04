import 'package:ecommerceapp/Views/Category_screen/category_controller/category_controller.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/consts/list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: title!.text.bold.make(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline))
        ],
      ),
      bottomNavigationBar: SizedBox(
        child: ourButton(
          onPressed: () {},
          text: "Add to cart",
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 260,
                itemCount: 3,
                viewportFraction: 1.0,
                itemBuilder: (context, index) {
                  return Image.asset(
                    model4,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "SubCategory".text.size(18).color(Colors.black45).make(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      title!.text.size(20).make(),
                      Obx(
                        () => Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.increment();
                              },
                              icon: Image.asset(
                                icPlus,
                                height: 30,
                              ),
                            ),
                            10.widthBox,
                            "${controller.counter.value}".text.make(),
                            10.widthBox,
                            IconButton(
                              onPressed: () {
                                controller.decrement();
                              },
                              icon: Image.asset(
                                icMinus,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  10.heightBox,
                  "Rs. 2000".text.color(Colors.red).bold.size(18).make(),
                  10.heightBox,
                  Row(
                    children: [
                      "Rating".text.size(16).make(),
                      10.widthBox,
                      VxRating(
                        onRatingUpdate: (value) {},
                        normalColor: Colors.black26,
                        selectionColor: Colors.orange,
                        count: 5,
                        size: 25,
                        stepInt: true,
                      ),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Seller".text.color(Colors.black45).make(),
                          5.heightBox,
                          "In House Brands".text.size(16).make(),
                        ],
                      ),
                      10.widthBox,
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.message_rounded,
                          color: Colors.black45,
                        ),
                      )
                    ],
                  )
                      .box
                      .height(60)
                      .color(const Color.fromARGB(255, 246, 233, 237))
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .shadowSm
                      .roundedSM
                      .make(),
                  20.heightBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: "Color".text.color(Colors.black87).make(),
                      ),
                      Row(
                        children: List.generate(
                            4,
                            (index) => VxBox()
                                .size(40, 40)
                                .roundedFull
                                .color(Vx.randomPrimaryColor)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .make()),
                      )
                    ],
                  ).box.padding(const EdgeInsets.all(8)).roundedSM.white.make(),
                  20.heightBox,
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: "Total".text.make(),
                      ),
                      "Rs. 00".text.size(18).bold.color(Colors.red).make()
                    ],
                  ).box.white.make(),
                  20.heightBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //description
                      "Description".text.size(18).make(),
                      10.heightBox,
                      "This is a dummy item and dummy description here.......\nThis is a dummy item and dummy description here......."
                          .text
                          .make(),
                      10.heightBox,
                    ],
                  ).box.white.make(),
                  20.heightBox,
                  "Products you may like".text.size(18).bold.make(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          modelslist.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  modelslist[index],
                                  width: 150,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                children: [
                                  VxRating(
                                    onRatingUpdate: (value) {},
                                    normalColor: Colors.grey.shade200,
                                    selectionColor: Colors.orange,
                                    count: 5,
                                    size: 15,
                                    stepInt: true,
                                  ),
                                  "(10)"
                                      .text
                                      .size(12)
                                      .color(Colors.black45)
                                      .make()
                                ],
                              ),
                              "Dorothy Perkhins"
                                  .text
                                  .size(12)
                                  .color(Colors.black45)
                                  .make(),
                              "Morning Dress"
                                  .text
                                  .size(16)
                                  .bold
                                  .color(Colors.black87)
                                  .make(),
                              "Rs. 2000"
                                  .text
                                  .size(16)
                                  .color(Colors.black87)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(4))
                              .make(),
                        ),
                      ),
                    ),
                  ),
                  5.heightBox
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
