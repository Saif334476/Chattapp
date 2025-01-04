import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/view/home/settings_view/password_reset_view.dart';
import 'package:whatsapp_clone/view/login/login.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Container(
        decoration: const BoxDecoration(color: Colors.white12),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset("assets/whatsapp.webp"),
                        ),
                        const Column(
                          children: [Text("SAIF"), Text("moto")],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.qr_code,
                          size: 30,
                        ))
                  ],
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordResetView()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.key,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Reset password etc.",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.lock_outline,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Privacy",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Block contacts,diappearing messages",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_outline_sharp,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avatar",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Create, edit, profile photo",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Favourites",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Add, reorder, remove",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chat_outlined,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chat",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Theme, wallpaper, chat history.",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Message, group & call tones",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.data_saver_off,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Storage and data",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Network usage, auto-download",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.public,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "App languages",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "English(device's language",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                selectedColor: Colors.white,
                hoverColor: const Color(0xff4ECB5C),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.help,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Help",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Help center, contact us, privacy policy",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.logout_outlined,
                          size: 25,
                        )),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        // Text(
                        //   "",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.w400, fontSize: 17),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
