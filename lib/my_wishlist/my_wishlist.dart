import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/consts/firebase_consts.dart';
import 'package:ecommerceapp/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyWishlist extends StatelessWidget {
  const MyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Wishlist".text.make(),
      ),
      body: StreamBuilder(
        stream: FirestoreService.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Wishlist yet!".text.make();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              "${data[index]['p_imgs'][0]}",
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: "${data[index]['p_name']}"
                              .text
                              .semiBold
                              .size(16)
                              .make(),
                          subtitle: "${data[index]['p_price']}"
                              .text
                              .color(Colors.red)
                              .semiBold
                              .make(),
                          trailing: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ).onTap(() async {
                            await firestore
                                .collection(productsCollection)
                                .doc(data[index].id)
                                .set({
                              'p_Wishlist':
                                  FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                          }),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
