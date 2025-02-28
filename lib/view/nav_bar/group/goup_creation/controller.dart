import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../model/contact_model.dart';
import '../../../../model/message_model.dart';

class GroupCreationController extends GetxController {
  RxList<Contact> selectedForGroup = <Contact>[].obs;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController groupName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    selectedForGroup.clear();
    super.onClose();
  }


  Future<void> sendGreet() async {
    List<String> participants =
    selectedForGroup.map((contact) => contact.email).toList();
    if (!participants.contains(userEmail)) {
      participants.add(userEmail!);
    }
    final text = "Group is Created by $userEmail";
    final chatDocRefId=await FirebaseFirestore.instance
        .collection("Whatsapp Clone")
        .doc("Data")
        .collection("Chats")
        .doc();
     await chatDocRefId
        .set({
      "chatType":"group",
      "name":groupName.text,
      "participants": participants,
      "lastMessage": text,
      "lastMessageTime": DateTime.now(),
      "createdAt": DateTime.now(),
      "chatId": chatDocRefId.id,
    }, SetOptions(merge: true));
    final newMessage = MessageModel(
      messageId: DateTime.now().toString(),
      message: text,
      senderId: "System",
      messageType: 'text',
      sentAt: DateTime.now(),
      isDelivered: true,
      isSeen: false,
    );

    await FirebaseFirestore.instance
        .collection("Whatsapp Clone")
        .doc("Data")
        .collection("Chats")
        .doc(chatDocRefId.id)
        .collection("Messages")
        .add(newMessage.toMap());

  }
}
