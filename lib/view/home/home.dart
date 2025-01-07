import 'package:flutter/material.dart';
import 'package:whatsapp_clone/view/home/settings_view/settings_view.dart';
import 'package:whatsapp_clone/view/home/status/status_view.dart';
import 'chat_list/chat_list.dart';
import 'group_list/group_list.dart';
import 'call.dart';

class NHomePage extends StatefulWidget {
  const NHomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<NHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
     ChatList(),
    const GroupList(),
    const StatusView(),
    const CallView()
  ];

  void navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Chatapp",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,fontFamily: "Courier",),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 25,
                      )),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      final RenderBox button =
                          context.findRenderObject() as RenderBox;
                      final Offset position = button.localToGlobal(Offset.zero);
                      showMenu(
                        context: context,
                        position: RelativeRect.fromRect(
                          Rect.fromLTWH(
                            position.dx +
                                button.size.width, // Adjust x-position to right
                            position.dy +
                                70, // Adjust y-position to be slightly lower
                            0, // width
                            0, // height
                          ),
                          Rect.fromLTWH(0, 0, MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                        ),
                        items: [
                          PopupMenuItem(
                            value: 'newGroup',
                            onTap: () {
                              // Handle new group
                            },
                            child: const Text('New group'),
                          ),
                          PopupMenuItem(
                            value: 'newBroadcast',
                            onTap: () {
                              // Handle new broadcast
                            },
                            child: const Text('New broadcast'),
                          ),
                          PopupMenuItem(
                            value: 'web',
                            onTap: () {
                              // Handle WhatsApp Web
                            },
                            child: const Text('WhatsApp Web'),
                          ),
                          PopupMenuItem(
                            value: 'settings',
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingsView()));
                            },
                            child: const Text('Settings'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          backgroundColor: const Color(0xff00112B)),
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        // clipBehavior: Clip.hardEdge,
        // decoration: const BoxDecoration(
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(8),
        //     topRight: Radius.circular(8),
        //   ),
        // ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white70,
          currentIndex: _currentIndex,
          iconSize: 30,
          onTap: navigateTo,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined), label: 'Chats'),
            BottomNavigationBarItem(icon: Icon(Icons.group_rounded), label: 'Groups'),
            BottomNavigationBarItem(
                icon: Icon(Icons.circle_outlined ), label: 'Status'),
            BottomNavigationBarItem(
                icon: Icon(Icons.phone), label: 'Calls'),

          ],
          backgroundColor: const Color(0xff00112B),
          selectedItemColor: const Color(0xce9dd1ff),
          unselectedLabelStyle:
              TextStyle(color: Colors.white10.withOpacity(0.5)),
          selectedLabelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
