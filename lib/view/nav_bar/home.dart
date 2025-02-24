import 'package:flutter/material.dart';
import 'package:whatsapp_clone/view/nav_bar/settings_view/settings_view.dart';
import 'package:whatsapp_clone/view/nav_bar/status/status_view.dart';
import 'chat_list/chat_list.dart';
import 'call.dart';
import 'group/group_list.dart';

class NHomePage extends StatefulWidget {
  const NHomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<NHomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _children = [
    ChatList(),
    const GroupList(),
    const StatusView(),
    const CallView(),
  ];

  void navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInCubic,
    );
  }

  String _currentScreen() {
    switch (_currentIndex) {
      case 0:
        return "Chats";
      case 1:
        return "Groups";
      case 2:
        return "Status";
      case 3:
        return "Calls";
      default:
        return "Chats";
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _currentScreen(),
              style: TextStyle(

                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    )),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final RenderBox button =
                    context.findRenderObject() as RenderBox;
                    final Offset position = button.localToGlobal(Offset.zero);
                    showMenu(
                      context: context,
                      position: RelativeRect.fromRect(
                        Rect.fromLTWH(
                          position.dx + button.size.width, // Adjust x-position to right
                          position.dy + 70, // Adjust y-position to be slightly lower
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const SettingsView()));
                          },
                          child: const Text('Settings'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Color(0xFF388E3C), // Dark Green for AppBar
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _children,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF81C784).withOpacity(0.1), // Light Green shadow
              blurRadius: 8,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          iconSize: 30,
          onTap: navigateTo,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined), label: 'Chats'),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_rounded), label: 'Groups'),
            BottomNavigationBarItem(
                icon: Icon(Icons.circle_outlined), label: 'Status'),
            BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Calls'),
          ],
          backgroundColor: Color(0xFF388E3C),
          selectedItemColor: Colors.white, // Dark Green for selected items
          unselectedItemColor: Colors.grey[1], // Grey for unselected items
        ),
      ),
    );
  }
}
