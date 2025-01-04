import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/view/home/chat/chat.dart';
import '../../../Controllers/contact_list_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ContactListController controller = Get.put(ContactListController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff00112B),
        title: const Text(
          "Contact List",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.contactList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.separated(
          itemCount: controller.contactList.length,
          itemBuilder: (BuildContext context, int index) {
            final contact = controller.contactList[index];
            final String email = contact.email;
            return ListTile(
              tileColor: Color(0xce9dd1ff),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatView(
                      id: "${FirebaseAuth.instance.currentUser?.email}-$email",
                      recipentsId: email,
                    ),
                  ),
                );
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
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              decoration: const BoxDecoration(color: Colors.grey),
              height: 1,
            );
          },
        );
      }),
    );
  }
}
