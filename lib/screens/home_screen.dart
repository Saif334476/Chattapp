import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurStyle: BlurStyle.outer, blurRadius: 2)
            ],
            color: Color(0xECE6E6FF),
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              height: MediaQuery.sizeOf(context).height * 0.25,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.11,
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white10),
                            boxShadow: [BoxShadow(color: Colors.grey)],
                            color: Color(0xECE6E6FF),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Energy",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            Text(
                              "2.4 KWH",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            Text(
                              "-12% vs yesterday",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        height: MediaQuery.sizeOf(context).height * 0.11,
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        decoration: BoxDecoration(
                            color: Color(0xECE6E6FF),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Temperature",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            Text(
                              "23°C",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            Text(
                              "Optimal range",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    height: MediaQuery.sizeOf(context).height * 0.09,
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(
                        color: Color(0xECE6E6FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Text(
                              "Internet Status",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            Row(children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Connected",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )
                            ])
                          ]),
                          Column(
                            children: [
                              Text(
                                "300 MbPs",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Download",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ]),
                  )
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
