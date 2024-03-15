import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/consts/firebase_consts.dart';
import 'package:ecommerceapp/controller/chats_controller.dart';
import 'package:ecommerceapp/messages/components/sender_bubble.dart';
import 'package:ecommerceapp/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var controller = Get.put(ChatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 173, 212, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 162, 206, 243),
        title: "${controller.friendName}".text.make(),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirestoreService.getChatMessages(controller.chatDocId),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: "Send a message.......".text.make(),
                    );
                  } else {
                    return ListView(
                      children:
                          snapshot.data!.docs.mapIndexed((currentValue, index) {
                        var data = snapshot.data!.docs[index];
                        return Align(
                          alignment: data['uid'] == currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: senderBubble(data),
                        );
                      }).toList(),
                    );
                  }
                }),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                      hintText: "Type a message......."),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.red,
                ),
              ),
            ],
          )
              .box
              .height(70)
              .color(
                const Color.fromARGB(255, 162, 206, 243),
              )
              .padding(const EdgeInsets.all(12))
              .make()
        ],
      ),
    );
  }
}
