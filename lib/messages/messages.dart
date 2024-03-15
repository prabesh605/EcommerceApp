import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/messages/chat_screen.dart';
import 'package:ecommerceapp/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Messages".text.make(),
      ),
      body: StreamBuilder(
        stream: FirestoreService.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Messages yet!".text.make();
          } else {
            var data = snapshot.data!.docs;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(() => const ChatScreen(), arguments: [
                                data[index]['friend_name'],
                                data[index]['toId'],
                              ]);
                            },
                            leading: const CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.person,
                              ),
                            ),
                            title: "${data[index]['friend_name']}"
                                .text
                                .semiBold
                                .make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),
                          ),
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
