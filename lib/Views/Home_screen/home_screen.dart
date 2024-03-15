import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Views/Category_screen/item_details.dart';
import 'package:ecommerceapp/Views/Home_screen/components/search_screen.dart';
import 'package:ecommerceapp/Views/collections/fashion_collections.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/consts/list.dart';
import 'package:ecommerceapp/controller/home_controller.dart';
import 'package:ecommerceapp/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //first vxswiper
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: VxSwiper.builder(
                          height: MediaQuery.of(context).size.height / 1.6,
                          autoPlay: true,
                          itemCount: fashionSliderlist.length,
                          viewportFraction: 1.0,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              fashionSliderlist[index],
                              filterQuality: FilterQuality.low,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ).box.make();
                          }),
                    ),
                    Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Fashion \nSales"
                                .text
                                .size(60)
                                .lineHeight(1)
                                .bold
                                .color(Colors.white)
                                .make(),
                            10.heightBox,
                            SizedBox(
                                width: 180,
                                child: ourButton(
                                    text: "Check",
                                    onPressed: () {
                                      Get.to(() => const FashionCollections(
                                          title: 'fashion'));
                                    }))
                          ],
                        )),
                  ],
                ),
                10.heightBox,
                //new products
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "New".text.color(Colors.black87).size(30).bold.make(),
                          "You have never seen this before"
                              .text
                              .color(Colors.black87)
                              .size(16)
                              .normal
                              .make()
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: "View all "
                          .text
                          .color(Colors.black54)
                          .size(20)
                          .make(),
                    )
                  ],
                ),
                10.heightBox,
                StreamBuilder(
                    stream: FirestoreService.allProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var allProductsData = snapshot.data!.docs;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                allProductsData.length,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            allProductsData[index]['p_imgs'][0],
                                            width: 150,
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 10,
                                            left: 10,
                                            height: 40,
                                            width: 50,
                                            child: ourButton(text: "New"),
                                          ),
                                        ],
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
                                    "${allProductsData[index]['p_subcategory']}"
                                        .text
                                        .size(12)
                                        .color(Colors.black45)
                                        .make(),
                                    "${allProductsData[index]['p_name']}"
                                        .text
                                        .size(16)
                                        .bold
                                        .color(Colors.black87)
                                        .make(),
                                    "Rs. ${allProductsData[index]['p_price']}"
                                        .text
                                        .size(16)
                                        .color(Colors.black87)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .padding(const EdgeInsets.all(4))
                                    .make()
                                    .onTap(() {
                                  Get.to(
                                    () => ItemDetails(
                                      title:
                                          "${allProductsData[index]['p_subcategory']}",
                                      data: allProductsData[index],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      }
                    }),

                10.heightBox,
                //top sales
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Sales"
                              .text
                              .color(Colors.black87)
                              .size(30)
                              .bold
                              .make(),
                          "Super summer sales"
                              .text
                              .color(Colors.black87)
                              .size(16)
                              .normal
                              .make()
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: "View all "
                          .text
                          .color(Colors.black54)
                          .size(20)
                          .make(),
                    )
                  ],
                ),
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
                              child: Stack(
                                children: [
                                  Image.asset(
                                    modelslist[index],
                                    width: 150,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    height: 40,
                                    width: 60,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          padding: const EdgeInsets.all(12)),
                                      onPressed: () {},
                                      child: "-20%".text.white.bold.make(),
                                    ),
                                  ),
                                ],
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
                //featured collection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Featured"
                              .text
                              .color(Colors.black87)
                              .size(30)
                              .bold
                              .make(),
                          "Featured collection"
                              .text
                              .color(Colors.black87)
                              .size(16)
                              .normal
                              .make()
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: "View all "
                          .text
                          .color(Colors.black54)
                          .size(20)
                          .make(),
                    )
                  ],
                ),
                10.heightBox,
                FutureBuilder(
                    future: FirestoreService.getFeaturedProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var featuredData = snapshot.data!.docs;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                featuredData.length,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            featuredData[index]['p_imgs'][0],
                                            width: 150,
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 10,
                                            left: 10,
                                            height: 40,
                                            width: 50,
                                            child: ourButton(text: "New"),
                                          ),
                                        ],
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
                                    "${featuredData[index]['p_subcategory']}"
                                        .text
                                        .size(12)
                                        .color(Colors.black45)
                                        .make(),
                                    "${featuredData[index]['p_name']}"
                                        .text
                                        .size(16)
                                        .bold
                                        .color(Colors.black87)
                                        .make(),
                                    "Rs. ${featuredData[index]['p_price']}"
                                        .text
                                        .size(16)
                                        .color(Colors.black87)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .padding(const EdgeInsets.all(4))
                                    .make()
                                    .onTap(() {
                                  Get.to(
                                    () => ItemDetails(
                                      title:
                                          "${featuredData[index]['p_subcategory']}",
                                      data: featuredData[index],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      }
                    }),

                //new collection
                Stack(
                  children: [
                    Image.asset(
                      yellowGirl,
                      width: double.infinity,
                      height: 300,
                    ),
                    Positioned(
                        bottom: 10,
                        left: 5,
                        child: "New Collection".text.bold.white.size(40).make())
                  ],
                ).onTap(() {
                  Get.to(() => const FashionCollections(
                        title: 'new',
                      ));
                }),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        children: [
                          //men hoodie
                          Image.asset(
                            manindhoodie,
                            width: MediaQuery.of(context).size.width / 2,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              bottom: 10,
                              left: 45,
                              child: "Men \n hoodies"
                                  .text
                                  .bold
                                  .white
                                  .size(40)
                                  .make())
                        ],
                      ).onTap(() {
                        Get.to(() => const FashionCollections(
                              title: 'men_hoodie',
                            ));
                      }),
                    ),
                    //summer sales
                    Align(
                            alignment: Alignment.bottomLeft,
                            child: "Summer \nSales"
                                .text
                                .bold
                                .color(Colors.red)
                                .size(40)
                                .make())
                        .onTap(() {
                      Get.to(() => const FashionCollections(
                            title: 'summer_sales',
                          ));
                    }),
                    //black clothes
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Stack(
                        children: [
                          Image.asset(
                            blackfashion,
                            width: MediaQuery.of(context).size.width / 2,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              top: 10,
                              left: 45,
                              child: "Black".text.bold.white.size(40).make())
                        ],
                      ).onTap(() {
                        Get.to(() => const FashionCollections(
                              title: 'black',
                            ));
                      }),
                    ),
                  ],
                )
              ],
            ),
          ),
          //search bar on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor:
                  const Color.fromARGB(255, 179, 211, 235).withOpacity(0.2),
              elevation: 0,
              title: TextField(
                controller: controller.searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
                onSubmitted: (_) {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Get.to(() =>
                        SearchScreen(title: controller.searchController.text));
                    controller.searchController.clear();
                  }
                },
              ),
              leading: const Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
