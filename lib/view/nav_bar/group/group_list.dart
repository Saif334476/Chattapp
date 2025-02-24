import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Controllers/contact_list_controller.dart';
import '../../../Controllers/group.dart';
import '../chat/chat.dart';
import 'goup_creation/create_group.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  final ContactListController controller = Get.put(ContactListController());
  final GroupListController groupListController =
      Get.put(GroupListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(children: [
          Container(
            decoration:
                BoxDecoration(color: Color(0xFF81C784).withOpacity(0.1)),
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => CreateGroup(),
                      transition: Transition.leftToRightWithFade,
                      duration: Duration(milliseconds: 300));
                },
                child: Card(
                  margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: ListTile(
                    leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Color(0xFF388E3C), width: 1)),
                        // padding: EdgeInsets.all(5),
                        child: const Icon(
                          Icons.group_add_outlined,
                          color: Color(0xFF388E3C), // Blue accent color
                          size: 30,
                        )),
                    title: Text(
                      "Create New Group",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text("Tap to create group"),
                  ),
                ),
              ),
              groupListController.chatList.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        itemCount: groupListController.chatList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final chat = groupListController.chatList[index];
                          var chatId = chat.chatId;
                          var lastMessage = chat.lastMessage;
                          var lastMessageTime =
                              chat.lastMessageTime ?? DateTime.now();
                          var formattedTime =
                              DateFormat('HH:mm').format(lastMessageTime);

                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatView(
                                      id: chatId,
                                      recipentsId: chat.participants.firstWhere(
                                        (id) =>
                                            id !=
                                            FirebaseAuth
                                                .instance.currentUser?.email,
                                      ),
                                    ),
                                  ),
                                );
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      chatId,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
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
                      ),
                    )
                  : Expanded(
                      child: const Center(
                        child: Text(
                          "No Active Chats",
                          style:
                              TextStyle(color: Color(0xFF388E3C), fontSize: 16),
                        ),
                      ),
                    ),

              // ➕ Floating Action Button for Adding Contacts
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF388E3C), // Matches the theme
              elevation: 2,
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    childBuilder: (context) => CreateGroup(),
                  ),
                );
              },
              child: const Icon(
                Icons.group_add_outlined,
                color: Colors.white, // Blue accent color
                size: 30,
              ),
            ),
          ),
        ]);
      }),
    );
  }
}
