import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Controllers/contact_list_controller.dart';
import '../../../Controllers/group.dart';
import '../../../theme/theme_controller.dart';
import '../chat/chat.dart';
import 'goup_creation/create_group.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {

  final GroupListController groupListController = Get.find();

  final ThemeController themeController = Get.find();

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
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.12,
              ),

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
                        child: const Icon(
                          Icons.group_add_outlined,
                          color: Color(0xFF388E3C),
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
                      horizontal: 10, vertical: 10),
                  itemCount: groupListController.chatList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final chat = groupListController.chatList[index];
                    var chatName = chat.name;
                    var chatId = chat.chatId;
                    var lastMessage = chat.lastMessage;
                    var lastMessageTime =
                        chat.lastMessageTime ?? DateTime.now();
                    var formattedTime =
                    DateFormat('HH:mm').format(lastMessageTime);

                    return Card(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Obx(() => Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF388E3C)
                                  .withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(2, 4),
                            ),
                          ],
                          color: themeController.isDarkMode.value
                              ? Colors.grey[900]
                              : Colors.white,
                          border: Border(
                            right: BorderSide(
                                color: Color(0xFF388E3C),
                                width:
                                MediaQuery.sizeOf(context).width *
                                    0.02),
                            left: BorderSide(
                                color: Color(0xFF388E3C),
                                width:
                                MediaQuery.sizeOf(context).width *
                                    0.02),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(
                                    () => ChatView(
                                  name: chatName,
                                  type: "Group",
                                  id: chatId,
                                  recipentsId:
                                  chat.participants
                                      .firstWhere(
                                        (id) =>
                                    id !=
                                        FirebaseAuth.instance
                                            .currentUser?.email,
                                  ),
                                ),
                                transition: Transition.fade,
                                duration: Duration(milliseconds: 300));
                          },
                          leading: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0xFF388E3C),
                                    width: 1)),
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
                            chatName ?? "Unnamed Group",
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
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.5,
                                child: Text(
                                  lastMessage,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                  themeController.isDarkMode.value
                                      ? TextStyle(
                                      color: Colors.white70)
                                      : TextStyle(
                                      color: Colors.black87),
                                ),
                              ),
                              Text(
                                formattedTime,
                                style:
                                themeController.isDarkMode.value
                                    ? TextStyle(
                                    color: Colors.white54)
                                    : TextStyle(
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      )),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 8),
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
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: themeController.isDarkMode.value
                  ? Colors.grey[800] // Dark Mode Color
                  : Color(0xFF388E3C),
              elevation: 2,
              onPressed: () {
                Get.to(() => CreateGroup(),
                    transition: Transition.fade,
                    duration: Duration(milliseconds: 300));
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
