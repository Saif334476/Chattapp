import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/model/message_model.dart';

class ChatController extends GetxController {
  String chatId;
  String? recipentsId;
  String? type;
  ChatController(this.chatId, this.recipentsId, this.type);
  RxList<MessageModel> messages = <MessageModel>[].obs;
  RxBool isEmojiShowing = false.obs;
  RxBool isWriting = false.obs;
  late TextEditingController messageController;

  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();
    getMessagesCollectionStream();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void getMessagesCollectionStream() {
    try {
      Stream<QuerySnapshot> allMessages = FirebaseFirestore.instance
          .collection('Whatsapp Clone')
          .doc('Data')
          .collection('Chats')
          .doc(chatId)
          .collection('Messages')
          .orderBy('sentAt')
          .snapshots();
      allMessages.listen((QuerySnapshot snapshot) {
        messages.value = snapshot.docs
            .map((doc) =>
                MessageModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print('Error streaming messages: $e');
    }
  }

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    final text = messageController.text.trim();
    messageController.clear();
    isWriting.value = false;
    if (type == "single") {
      if (recipentsId != null) {
        await FirebaseFirestore.instance
            .collection("Whatsapp Clone")
            .doc("Data")
            .collection("Chats")
            .doc(chatId)
            .set({
          "participants": [
            FirebaseAuth.instance.currentUser?.email,
            recipentsId,
          ],
          "chatType": "single",
          "lastMessage": text,
          "lastMessageTime": DateTime.now(),
          "createdAt": DateTime.now(),
          "chatId": chatId,
        }, SetOptions(merge: true));
      } else {

      }
    }
    await FirebaseFirestore.instance
        .collection("Whatsapp Clone")
        .doc("Data")
        .collection("Chats")
        .doc(chatId)
        .set({
      "lastMessage": text,
      "lastMessageTime": DateTime.now(),
    }, SetOptions(merge: true));
    final newMessage = MessageModel(
      messageId: DateTime.now().toString(),
      message: text,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      messageType: 'text',
      sentAt: DateTime.now(),
      isDelivered: true,
      isSeen: false,
    );

    await FirebaseFirestore.instance
        .collection("Whatsapp Clone")
        .doc("Data")
        .collection("Chats")
        .doc(chatId)
        .collection("Messages")
        .add(newMessage.toMap());
  }
}
