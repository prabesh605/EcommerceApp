import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/controller/home_controller.dart';
import 'package:ecommerceapp/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.title});
  final String? title;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 216, 238),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 211, 235),
        elevation: 0,
        title: TextField(
          controller: controller.searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: FirestoreService.searchProducts(widget.title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No products found".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data
                  .where((element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(widget.title!.toLowerCase()))
                  .toList();
              return GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                children: filtered
                    .mapIndexed(
                      (currentValue, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          10.heightBox,
                          SizedBox(
                            height: 180,
                            width: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                filtered[index]['p_imgs'][0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          5.heightBox,
                          "${filtered[index]['p_name']}".text.semiBold.make(),
                          "Rs. ${filtered[index]['p_price']}"
                              .text
                              .color(Colors.red)
                              .bold
                              .size(16)
                              .make(),
                          10.heightBox
                        ],
                      ).box.white.shadowSm.roundedSM.make(),
                    )
                    .toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
