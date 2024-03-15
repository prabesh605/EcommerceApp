import 'package:ecommerceapp/controller/product_controller.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/consts/list.dart';
import 'package:ecommerceapp/messages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, this.title, this.data});
  final String? title;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    bool inquantity = false;
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        controller.resetValues();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: title!.text.bold.make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id, context);
                    } else {
                      controller.addToWishlist(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    color: controller.isFav.value ? Colors.red : Colors.black,
                  )),
            )
          ],
        ),
        bottomNavigationBar: SizedBox(
          child: ourButton(
            onPressed: () async {
              await controller.addToCart(
                color: data['p_colors'][controller.colorIndex.value],
                context: context,
                img: data['p_imgs'][0],
                qty: controller.counter.value,
                sellername: data['p_seller'],
                title: data['p_name'],
                tprice:
                    inquantity ? controller.totalPrice.value : data['p_price'],
                vendorID: data['vendor_id'],
              );
              VxToast.show(context, msg: "Added to Cart");
            },
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
                  itemCount: data['p_imgs'].length,
                  viewportFraction: 1.0,
                  itemBuilder: (context, index) {
                    return Image.network(
                      data['p_imgs'][index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "${data['p_subcategory']}"
                          .text
                          .size(18)
                          .color(Colors.black45)
                          .make(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "${data['p_name']}".text.size(20).make(),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  inquantity = true;
                                  await controller.decrement();
                                  await controller.calculateTotalPrice(
                                      int.parse(data['p_price']));
                                },
                                icon: Image.asset(
                                  icMinus,
                                  height: 30,
                                ),
                              ),
                              10.widthBox,
                              "${controller.counter.value}".text.make(),
                              10.widthBox,
                              IconButton(
                                onPressed: () async {
                                  inquantity = true;
                                  await controller.increment();
                                  await controller.calculateTotalPrice(
                                      int.parse(data['p_price']));
                                },
                                icon: Image.asset(
                                  icPlus,
                                  height: 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      10.heightBox,
                      "Rs. ${data['p_price']}"
                          .text
                          .color(Colors.red)
                          .bold
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          "Rating".text.size(16).make(),
                          10.widthBox,
                          VxRating(
                            isSelectable: false,
                            value: double.parse(data['p_rating']),
                            maxRating: 5,
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
                              "${data['p_seller']}".text.size(16).make(),
                            ],
                          ),
                          10.widthBox,
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: Colors.black45,
                            ),
                          ).onTap(() {
                            Get.to(() => const ChatScreen(), arguments: [
                              data['p_seller'],
                              data['vendor_id'],
                            ]);
                          })
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
                              data['p_colors'].length,
                              (index) => Stack(
                                alignment: Alignment.center,
                                children: [
                                  VxBox()
                                      .size(40, 40)
                                      .roundedFull
                                      .color(Color(data['p_colors'][index]))
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .make()
                                      .onTap(() {
                                    controller.changeColorIndex(index);
                                  }),
                                  Visibility(
                                    visible:
                                        index == controller.colorIndex.value,
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(8))
                          .roundedSM
                          .white
                          .make(),
                      20.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Total".text.make(),
                          ),
                          inquantity
                              ? "Rs. ${controller.totalPrice.value}"
                                  .text
                                  .size(18)
                                  .bold
                                  .color(Colors.red)
                                  .make()
                              : "Rs. ${data['p_price']}"
                                  .text
                                  .size(18)
                                  .bold
                                  .color(Colors.red)
                                  .make()
                        ],
                      ).box.white.make(),
                      20.heightBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //description
                          "Description".text.size(18).make(),
                          10.heightBox,
                          "${data['p_desc']}".text.make(),
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
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
