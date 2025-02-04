import 'package:flutter/material.dart';
import 'package:home_automation/screens/rooms_screen.dart';
import 'package:home_automation/screens/scenes_screen.dart';
import 'package:home_automation/screens/settings_screen.dart';

import 'devices_screen.dart';
import 'home_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _children = [
    HomeScreen(),
    const RoomsScreen(),
    const DevicesScreen(),
    const ScenesScreen(),
    SettingsScreen()
  ];

  void navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInCubic,
    );
  }

  Widget _currentScreen() {
    switch (_currentIndex) {
      case 0:
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Text(
              "AB", // User initials
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          title: Text("Welcome back"),
          subtitle: Text("Saif"),
          trailing: ElevatedButton(
              onPressed: () {}, child: Icon(Icons.notifications)),
        );

      case 1:
        return Text("text");
      case 2:
        return Text("text");
      case 3:
        return Text("text");
      case 4:
        return Text("text");
      default:
        return Text("text");
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
          title: _currentScreen(),
          backgroundColor: Colors.blueGrey),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _children,
      ),
      //   _children[_currentIndex],

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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.meeting_room_outlined), label: 'Rooms'),
            BottomNavigationBarItem(
                icon: Icon(Icons.power), label: 'Devices'),
            BottomNavigationBarItem(
                icon: Icon(Icons.call_to_action_outlined), label: 'Scenes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          backgroundColor: Colors.blueGrey,
          selectedItemColor: const Color(0xff00112B),
          unselectedLabelStyle:
              TextStyle(color: Colors.white10.withOpacity(0.5)),
          selectedLabelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
