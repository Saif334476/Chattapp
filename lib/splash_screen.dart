import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';


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


        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return  LoginScreen();
        }));

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
                child: Image.asset("assets/ic_launcher.png")),
            Text(
              "Smart Nest",
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
