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
      body: Stack(children: [
        Container(
          color: Color(0xff1A2941),
        ),
        Center(
          child: Text(
            "Group chats will appear here",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        )
      ]),
    );
  }
}
