import 'package:flutter/material.dart';


class CallView extends StatefulWidget {
  const CallView({super.key});

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(
          "Calls VIEW",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
