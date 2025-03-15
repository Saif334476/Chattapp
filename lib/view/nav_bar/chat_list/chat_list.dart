import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../chat/chat.dart';
import '../../../Controllers/contact_list_controller.dart';
import '../../../theme/theme_controller.dart';
import 'contacts_list.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});

  final ContactListController controller = Get.put(ContactListController());
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(
                       color:  Color(0xFF81C784).withOpacity(0.1)
                    //  color: Colors.grey[100]
                  ),
            ),
            controller.chatList.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.12,
                      ),
                      Expanded(
                        child: ListView.separated(
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
                              margin: EdgeInsets.only(bottom: 8),
                              // child: Obx(() => Container(
                              //   padding: EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //     boxShadow: [
                              //       BoxShadow(
                              //         color: Color(0xFF388E3C).withOpacity(0.2),
                              //         spreadRadius: 1,
                              //         blurRadius: 6,
                              //         offset: Offset(2, 4),
                              //       ),
                              //     ],
                              //     color: themeController.isDarkMode.value
                              //         ? Colors.grey[900]
                              //         : Colors.white,
                              //     border: Border(
                              //       right: BorderSide(
                              //           color: Color(0xFF388E3C),
                              //           width: MediaQuery.sizeOf(context).width *
                              //               0.02),
                              //       left: BorderSide(
                              //           color: Color(0xFF388E3C),
                              //           width: MediaQuery.sizeOf(context).width *
                              //               0.02),
                              //     ),
                              //     borderRadius: BorderRadius.circular(15),
                              //   ),
                              child: ListTile(
                                onTap: () {
                                  Get.to(
                                      () => ChatView(
                                            id: chat.chatId,
                                            name: controller
                                                .recipientNames[chat.chatId],
                                            recipentsId:
                                                chat.participants.firstWhere(
                                              (id) =>
                                                  id !=
                                                  FirebaseAuth.instance
                                                      .currentUser?.email,
                                            ),
                                            type: "single",
                                          ),
                                      transition: Transition.fade,
                                      duration: Duration(milliseconds: 300));
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
                                title: Text(
                                  controller.recipientNames[chat.chatId] ?? "",
                                  style: themeController.isDarkMode.value
                                      ? TextStyle(color: Colors.white)
                                      : TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        lastMessage,
                                        overflow: TextOverflow.ellipsis,
                                        style: themeController.isDarkMode.value
                                            ? TextStyle(color: Colors.white70)
                                            : TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                    Text(
                                      formattedTime,
                                      style: themeController.isDarkMode.value
                                          ? TextStyle(color: Colors.white54)
                                          : TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              //  )
                              // ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 1),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      "No Active Chats",
                      style: themeController.isDarkMode.value
                          ? TextStyle(color: Colors.white70)
                          : TextStyle(color: Color(0xFF388E3C)),
                    ),
                  ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Obx(() => FloatingActionButton(
                    backgroundColor: themeController.isDarkMode.value
                        ? Colors.grey[800] // Dark Mode Color
                        : Color(0xFF388E3C),
                    elevation: 2,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactList()));
                    },
                    child: const Icon(
                      Icons.add_comment,
                      color: Colors.white,
                      size: 30,
                    ),
                  )),
            ),
          ],
        );
      }),
    );
  }
}
