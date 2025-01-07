import 'package:flutter/material.dart';


class CallView extends StatefulWidget {
  const CallView({super.key});

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Color(0xff1A2941),
        ),
        Center(
          child: Text(
            "Call logs will appear here",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        )
      ]),
    );
  }
}
