import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Views/Cart_Screen/shipping_screen.dart';
import 'package:ecommerceapp/common_widgets/our_button.dart';
import 'package:ecommerceapp/consts/firebase_consts.dart';
import 'package:ecommerceapp/controller/cart_controller.dart';
import 'package:ecommerceapp/services/firestore_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 200, 209),
        automaticallyImplyLeading: false,
        title: "My Cart".text.makeCentered(),
      ),
      bottomNavigationBar: SizedBox(
        child: Container(
          color: Colors.red,
          child: ourButton(
            onPressed: () {
              Get.to(() => const ShippingDetails());
            },
            text: "Procced to Shipping",
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 229, 208, 215),
      body: Center(
        child: StreamBuilder(
          stream: FirestoreService.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is empty".text.make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Obx(
                () => Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  "${data[index]['img']}",
                                  fit: BoxFit.cover,
                                )),
                            title:
                                "${data[index]['title']} (x${data[index]['qty']})"
                                    .text
                                    .size(16)
                                    .make(),
                            subtitle: "Rs. ${data[index]['tprice']}"
                                .text
                                .color(Colors.red)
                                .make(),
                            trailing: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ).onTap(() {
                              FirestoreService.deleteDocument(data[index].id);
                            }),
                          )
                              .box
                              .height(80)
                              .white
                              .roundedSM
                              .shadowSm
                              .margin(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              )
                              .make();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price".text.bold.make(),
                        "Rs. ${controller.totalP.value}".text.bold.make()
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(const Color.fromARGB(255, 255, 119, 0))
                        .shadowSm
                        .roundedSM
                        .make()
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
