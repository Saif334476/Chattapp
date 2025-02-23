import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/view/home/chat/chat.dart';
import '../../../Controllers/contact_list_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactListController controller = Get.put(ContactListController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF388E3C),
        title: const Text(
          "Contact List",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.contactList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Color(0xFF81C784).withOpacity(0.1)),
            ),
            ListView.separated(
              itemCount: controller.contactList.length,
              itemBuilder: (BuildContext context, int index) {
                final contact = controller.contactList[index];
                final String email = contact.email;
                return Card(
                  child: ListTile(
                    onTap: () async {
                      final existingChat = await FirebaseFirestore.instance
                          .collection("Whatsapp Clone")
                          .doc("Data")
                          .collection("Chats")
                          .where("chatType", isEqualTo: "single")
                          .where("participants",
                              arrayContains:
                                  FirebaseAuth.instance.currentUser?.email)
                          .get();
                      final filteredChats = existingChat.docs.where((doc) {
                        final participants =
                            List<String>.from(doc.data()['participants'] ?? []);
                        return participants.contains(email);
                      }).toList();
                      if (filteredChats.isEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatView(
                              id: "${FirebaseAuth.instance.currentUser?.email}-$email",
                              recipentsId: email,
                            ),
                          ),
                        );
                      } else {
                        final existingChatId = filteredChats[0].id;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatView(
                              id: existingChatId,
                            ),
                          ),
                        );
                      }
                    },
                    leading: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent,
                      ),
                      height: 50,
                      width: 50,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/person.webp",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        email,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
            ),
          ],
        );
      }),
    );
  }
}
