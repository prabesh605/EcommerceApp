import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Views/Category_screen/item_details.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/controller/product_controller.dart';
import 'package:ecommerceapp/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        title: title.text.make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder(
          stream: FirestoreService.getProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No product found!".text.make(),
              );
            } else {
              var data = snapshot.data!.docs;
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
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
                        child: Image.network(
                          data[index]['p_imgs'][0],
                          height: 150,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      "${data[index]['p_subcategory']}"
                          .text
                          .size(12)
                          .color(Colors.black45)
                          .make(),
                      "${data[index]['p_name']}"
                          .text
                          .size(16)
                          .bold
                          .color(Colors.black87)
                          .make(),
                      "Rs. ${data[index]['p_price']}"
                          .text
                          .size(16)
                          .color(Colors.black87)
                          .make(),
                    ],
                  )
                      .box
                      .white
                      .margin(const EdgeInsets.symmetric(horizontal: 4))
                      .roundedSM
                      .outerShadowSm
                      .make()
                      .onTap(() {
                    controller.checkIfFav(data[index]);
                    Get.to(
                      () => ItemDetails(
                        title: "${data[index]['p_subcategory']}",
                        data: data[index],
                      ),
                    );
                  });
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
