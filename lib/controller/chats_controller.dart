import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/consts/firebase_consts.dart';
import 'package:ecommerceapp/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  var chats = firestore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var isLoading = false.obs;
  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  String? chatDocId;

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  getChatId() async {
    isLoading(true);
    try {
      final snapshot = await chats
          .where('users', isEqualTo: {
            friendId: null,
            currentId: null,
          })
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        chatDocId = snapshot.docs.single.id;
      } else {
        final newChatDoc = await chats.add({
          'created_on': null,
          'last_msg': '',
          'users': {friendId: null, currentId: null},
          'toId': '',
          'fromId': '',
          'friend_name': friendName,
          'sender_name': senderName,
        });
        chatDocId = newChatDoc.id;
      }
    } catch (e) {
      print("Error fetching chat ID: $e");
      // Handle error appropriately
    } finally {
      isLoading(false);
    }
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      await chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });
      await chats.doc(chatDocId).collection(messageCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
