import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/contact_model.dart';
import '../model/chat_model.dart';
import 'dart:async';

class ContactListController extends GetxController {
  RxList<Contact> contactList = <Contact>[].obs;
  RxList<Chat> chatList = <Chat>[].obs;
   String? uid;
   String? userEmail;
  StreamSubscription? chatSubscription;
  @override
  void onInit() {
     uid = FirebaseAuth.instance.currentUser?.uid;
     userEmail=FirebaseAuth.instance.currentUser?.email;
    super.onInit();
    getContact(uid);
    getChats(userEmail);
  }
  Future<void> handleLogout() async {
    try {
      await chatSubscription?.cancel();
      chatSubscription = null;

      contactList.clear();
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
  Future<void> getContact(uid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("Whatsapp Clone")
          .doc("Data")
          .collection("Users")
          .where("email", isNotEqualTo: userEmail)
          .get();
      contactList.value =snapshot.docs.map((doc) => Contact.fromJson(doc.data())).toList();
    } catch (e) {
      print("Error fetching contacts: $e");
    }
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
          ).snapshots();
      chats.listen((QuerySnapshot snapshot) {
        chatList.value =
            snapshot.docs.map((doc) => Chat.fromJson(doc.data() as Map<String,dynamic>)).toList();
      });
    } catch (e) {
      print("Error fetching chats: $e");
    }
  }
}
