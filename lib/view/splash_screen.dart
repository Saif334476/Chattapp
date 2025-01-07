import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/login_sample.dart';
import 'home/home.dart';
import 'login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const NHomePage()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const LoginView();
        }));
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset("assets/logo.webp")),
        Text(
          "Chatapp",
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontFamily: "Courier",
              color: Color(0xff00112B)),
        )
      ])),
    );
  }
}
