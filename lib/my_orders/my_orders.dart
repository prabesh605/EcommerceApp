import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/my_orders/order_details.dart';
import 'package:ecommerceapp/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Orders".text.make(),
      ),
      body: StreamBuilder(
        stream: FirestoreService.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders yet!".text.make();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}".text.bold.xl.make(),
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(Colors.red)
                      .make(),
                  subtitle: "Rs. ${data[index]['total_amount'].toString()}"
                      .text
                      .bold
                      .make(),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(() => OrdersDetail(
                            data: data[index],
                          ));
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                )
                    .box
                    .white
                    .margin(
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10))
                    .shadowSm
                    .make();
              },
            );
          }
        },
      ),
    );
  }
}
