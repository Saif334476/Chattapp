import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../chat/chat.dart';
import '../../../Controllers/contact_list_controller.dart';
import 'contacts_list.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});

  final ContactListController controller = Get.put(ContactListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Color(0xFF81C784).withOpacity(0.1)),
            ),
            controller.chatList.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    itemCount: controller.chatList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final chat = controller.chatList[index];
                      var lastMessage = chat.lastMessage;
                      var lastMessageTime =
                          chat.lastMessageTime ?? DateTime.now();
                      var formattedTime =
                          DateFormat('HH:mm').format(lastMessageTime);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          onTap: () {
                            Get.to(
                                () => ChatView(
                                      id: chat.chatId,
                                      name: controller
                                          .recipientNames[chat.chatId],
                                      recipentsId: chat.participants.firstWhere(
                                        (id) =>
                                            id !=
                                            FirebaseAuth
                                                .instance.currentUser?.email,
                                      ),
                                      type: "single",
                                    ),
                                transition: Transition.fade,
                                duration: Duration(milliseconds: 300));
                            //
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ChatView(
                            //       id: chatId,
                            //       recipentsId: chat.participants.firstWhere(
                            //         (id) =>
                            //             id !=
                            //             FirebaseAuth
                            //                 .instance.currentUser?.email,
                            //       ),type: "single",
                            //     ),
                            //   ),
                            // );
                          },
                          leading: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0xFF388E3C), width: 1)),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/person.webp",
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  controller.recipientNames[chat.chatId] ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  lastMessage,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.black54,
                                      ),
                                ),
                              ),
                              Text(
                                formattedTime,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.black54,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 2),
                  )
                : const Center(
                    child: Text(
                      "No Active Chats",
                      style: TextStyle(color: Color(0xFF388E3C), fontSize: 16),
                    ),
                  ),

            // ➕ Floating Action Button for Adding Contacts
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF388E3C), // Matches the theme
                elevation: 2,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactList()));
                },
                child: const Icon(
                  Icons.add_comment,
                  color: Colors.white, // Blue accent color
                  size: 30,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
