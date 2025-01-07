
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/view/home/chat_list/contacts_list.dart';
import '../chat/chat.dart';
import '../../../Controllers/contact_list_controller.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});

  final ContactListController controller = Get.put(ContactListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Center(
          child: Stack(
            children: [
              Stack(children: [
                Container(color: Color(0xff1A2941),),
        controller.chatList.isNotEmpty
        ?
              ListView.separated(
                      itemCount: controller.chatList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final chat = controller.chatList[index];
                        var chatId = chat.chatId;
                        var lastMessage = chat.lastMessage;
                        'No messages yet';
                        var lastMessageTime = chat.lastMessageTime != null
                            ? (chat.lastMessageTime)
                            : DateTime.now();
                        var formattedTime =
                            DateFormat('HH:mm').format(lastMessageTime);
                        return ListTile(
                          tileColor: const Color(0xff1A2941),
                          //  textColor:const Color(0xc7cdd1ff) ,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatView(
                                        id: chatId,
                                        recipentsId: chat.participants
                                            .firstWhere((id) =>
                                                id !=
                                                FirebaseAuth.instance
                                                    .currentUser?.email))));
                          },
                          leading: Container(
                            padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.transparent),
                              height: 50,
                              width: 50,
                              child:ClipOval(
                                  child: Image.asset(
                                "assets/person.webp",
                                fit: BoxFit.fill,
                              ))),
                          title: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                chatId,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,color: Colors.white),
                              )),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 20,
                                  child: Text(
                                    lastMessage,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,style: TextStyle( color: Colors.white70),
                                  )),
                              Text(formattedTime,style: TextStyle( color: Colors.white70),)
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.white70,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text("No Active Chats",style: TextStyle(color: Colors.white),),
                    ),]),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.7,
                left: MediaQuery.of(context).size.width * 0.75,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the border radius as needed
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactList()));
                  },
                  child: Material(
                    color: Colors.transparent,
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.zero)),
                    elevation: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.zero),
                        color: Color(0xff00112B),
                      ),
                      // color: const Color(0xff4ECB5C),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.add_comment,
                        size: 35,
                        color: Colors
                            .white, // Icon color inside the filled container
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
