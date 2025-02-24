import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../model/contact_model.dart';
import '../../../../model/message_model.dart';

class GroupCreationController extends GetxController {
  RxList<Contact> selectedForGroup = <Contact>[].obs;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  final uid = FirebaseAuth.instance.currentUser!.uid;

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

    await FirebaseFirestore.instance
        .collection("Whatsapp Clone")
        .doc("Data")
        .collection("Chats")
        .doc("chatIds")
        .set({
      "chatType":"group",
      "participants": participants,
      "lastMessage": text,
      "lastMessageTime": DateTime.now(),
      "createdAt": DateTime.now(),
      "chatId": "chatIds",
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
  }
}
