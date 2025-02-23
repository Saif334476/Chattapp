import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/chat_model.dart';
import 'dart:async';

class GroupListController extends GetxController {
  RxList<Chat> chatList = <Chat>[].obs;
  String? uid;
  String? userEmail;
  StreamSubscription? chatSubscription;
  @override
  void onInit() {
    uid = FirebaseAuth.instance.currentUser?.uid;
    userEmail = FirebaseAuth.instance.currentUser?.email;
    super.onInit();
    getChats(userEmail);
  }

  Future<void> handleLogout() async {
    try {
      await chatSubscription?.cancel();
      chatSubscription = null;

      chatList.clear();
      uid = null;
      userEmail = null;

      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  @override
  void onClose() {
    chatSubscription?.cancel();
    super.onClose();
  }

  Future<void> getChats(userEmail) async {
    try {
      Stream<QuerySnapshot> chats = FirebaseFirestore.instance
          .collection("Whatsapp Clone")
          .doc("Data")
          .collection("Chats")
          .where(
            "participants",
            arrayContains: userEmail,
          )
          .where("chatType", isEqualTo: "group")
          .snapshots();
      chats.listen((QuerySnapshot snapshot) {
        chatList.value = snapshot.docs
            .map((doc) => Chat.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print("Error fetching chats: $e");
    }
  }
}
