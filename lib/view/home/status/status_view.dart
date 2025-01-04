import 'package:flutter/material.dart';


class StatusView extends StatefulWidget {
  const StatusView({super.key});

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(
          "STATUS VIEW",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
