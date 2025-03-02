import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:animate_do/animate_do.dart';
import '../../theme/theme_controller.dart';
import 'chat_list/chat_list.dart';
import 'call.dart';
import 'group/group_list.dart';
import 'status/status_view.dart';
import 'settings_view/settings_view.dart';

class NHomePage extends StatefulWidget {
  const NHomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<NHomePage> {
  final ThemeController themeController = Get.find(); // GetX theme controller

  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _children = [
    ChatList(),
    const GroupList(),
    const StatusView(),
    const CallView(),
  ];

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
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigateTo(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _children,
          ),
      Obx(() => Positioned(
            top: MediaQuery.sizeOf(context).height * 0.05,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: themeController.isDarkMode.value ? Colors.black : const Color(0xFF388E3C),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _currentScreen(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search_rounded, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () => themeController.toggleTheme(),
                        icon: Obx(() => Icon(
                          themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                          color: Colors.white,
                        )),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {
                          showMenu(
                            context: context,
                            position: const RelativeRect.fromLTRB(100, 80, 0, 0),
                            items: [
                              PopupMenuItem(
                                value: 'settings',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SettingsView()));
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
            ),
          )),
        ],
      ),
      bottomNavigationBar: FadeInUp(
        child: Obx(() => Container(
          decoration: BoxDecoration(
            color: themeController.isDarkMode.value ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: GNav(
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 300),
              tabBackgroundColor:
              themeController.isDarkMode.value ? Colors.grey[800]! : const Color(0xFF388E3C),
              backgroundColor:
              themeController.isDarkMode.value ? Colors.black : Colors.white,
              color: themeController.isDarkMode.value ? Colors.white70 : Colors.grey,
              tabs: const [
                GButton(icon: Icons.chat_outlined, text: 'Chats'),
                GButton(icon: Icons.group_rounded, text: 'Groups'),
                GButton(icon: Icons.circle_outlined, text: 'Status'),
                GButton(icon: Icons.phone, text: 'Calls'),
              ],
              selectedIndex: _currentIndex,
              onTabChange: navigateTo,
            ),
          ),
        )),
      ),
    );
  }
}
