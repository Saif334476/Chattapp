import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/view/home/settings_view/password_reset_view.dart';
import 'package:whatsapp_clone/view/login/login.dart';
import 'dart:io';
import 'package:whatsapp_clone/reusable_widgets/profile_pic_widget.dart';
import 'package:whatsapp_clone/Controllers/contact_list_controller.dart';
import 'package:get/get.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  File? profilePicFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff00112B),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Settings",
                style:
                    TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ],
          ),
        ),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xff1A2941),
            ),
          ),
          Column(children: [

            Stack(children: [
              Stack(children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white),
                      color: Colors.white38),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset("assets/logo.webp"),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height*0.02,
                  right: 10,
                  child:
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xff1C4374),
                    ),
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),)
              ]),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.08,
                child: ProfilePicWidget(
                    onImagePicked: (imageUrl) {
                      setState(() {
                        profilePicFile = imageUrl;
                      });
                    },
                    uploadedProfileUrl: ""),
              )
            ]),
            const Divider(),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                    selectedColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PasswordResetView()));
                    },
                    leading: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.key,
                          size: 25,
                          color: Colors.white,
                        )),
                    title: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Reset password etc.",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.white70),
                        ),
                      ],
                    )),
                const Divider(),
                ListTile(
                    leading: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.lock_outline,
                          size: 25,
                          color: Colors.white,
                        )),
                    title: Text(
                      "Privacy",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Text(
                      "Block contacts,disappearing messages",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Colors.white70),
                    )),
                const Divider(),
                ListTile(
                  leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chat_outlined,
                        size: 25,
                        color: Colors.white,
                      )),
                  selectedColor: Colors.white,
                  title: Text(
                    "Chat",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    "Theme, wallpaper, chat history",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Colors.white70),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        size: 25,
                        color: Colors.white,
                      )),
                  selectedColor: Colors.white,
                  title: Text(
                    "Notifications",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    "Message, group & call tones",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Colors.white70),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.help,
                        size: 25,
                        color: Colors.white,
                      )),
                  selectedColor: Colors.white,
                  hoverColor: const Color(0xff4ECB5C),
                  title: Text(
                    "Help",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    "Contact Us, Privacy Policy",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Colors.white70),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.logout_outlined,
                        size: 25,
                        color: Colors.white,
                      )),
                  onTap: () async {
                    try {
                   //   await FirebaseAuth.instance.signOut();
                      ContactListController controller = Get.find<ContactListController>();
                      controller.handleLogout();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    } catch (e) {
                      print('Error signing out: $e');
                    }
                  },
                  selectedColor: Colors.white,
                  hoverColor: const Color(0xff4ECB5C),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            )
          ])
        ]));
  }
}
