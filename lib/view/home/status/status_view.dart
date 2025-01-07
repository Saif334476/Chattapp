import 'package:flutter/material.dart';

class StatusView extends StatefulWidget {
  const StatusView({super.key});

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        color: Color(0xff1A2941),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Status",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            ),
          ),
          ListTile(
            leading: Stack(children: [
              Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff00112B)),
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.transparent),
                  height: 50,
                  width: 50,
                  child: ClipOval(
                      child: Image.asset(
                    "assets/person.webp",
                    fit: BoxFit.fill,
                  ))),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: Offset(5, 5), // Adjust the position of the button
                    child: Container(
                      height: 25,width: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff00112B),
                            border: Border.all(color: Color(0xff00112B))),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              size: 10,
                              color: Colors.white,
                            ))),
                  ))
            ]),
            title: Text(
              "My status",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Tap to add status update",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Recent Updates",
                style: TextStyle(color: Colors.grey),
              ))
        ],
      )
    ]));
  }
}
