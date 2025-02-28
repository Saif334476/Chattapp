import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../animated.dart';
import 'auth/login.dart';
import 'nav_bar/home.dart';

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
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
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
          child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xFF81C784).withOpacity(0.1)
          ),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.height * 0.5,
                  child: Image.asset(
                    "assets/chatn.png",
                    color: Color(0xFF388E3C),
                  )),
              SizedBox(height: 15),
              BouncingDots(),
            ]),
      ])),
    );
  }
}
