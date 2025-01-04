import 'package:flutter/material.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "GROUP LIST",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
