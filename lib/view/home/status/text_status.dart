import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Controllers/status_controller.dart';

class TextStatusScreen extends StatelessWidget {
  final ColorController colorController = Get.put(ColorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children: [
          Obx(() => Container(
                color: colorController.currentColor.value,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: IntrinsicWidth(
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Enter Text",
                          isCollapsed: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                        ),
                        maxLines: null,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              )),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.05,
            left: MediaQuery.sizeOf(context).width * 0.02,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.05,
            right: MediaQuery.sizeOf(context).width * 0.02,
            child: IconButton(
                onPressed: () {
                  colorController.changeColor();
                },
                icon: Icon(
                  Icons.color_lens_outlined,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
