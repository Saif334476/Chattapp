import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:whatsapp_clone/reusable_widgets/reusable_widgets.dart';
import 'package:whatsapp_clone/Controllers/status_controller.dart';
import 'package:whatsapp_clone/reusable_widgets/camera_screen.dart';

class TextStatusScreen extends StatelessWidget {
  final ColorController colorController = Get.isRegistered<ColorController>()
      ? Get.find<ColorController>()
      : Get.put(ColorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(() => Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
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
          // KeyboardVisibilityBuilder(
          //   builder: (context, isKeyboardVisible) {
          //     return Positioned(
          //       bottom: isKeyboardVisible
          //           ? MediaQuery.of(context).viewInsets.bottom
          //           : 0, // Position above the keyboard if it's visible
          //       child: Container(
          //
          //         color: Colors.transparent,
          //         height: MediaQuery.sizeOf(context).height * 0.06,
          //         width: MediaQuery.sizeOf(context).width,
          //         child:
          //
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Row(
          //               children: [
          //                 SizedBox(width: 5),
          //                 ElevatedButton(
          //                   onPressed: () {
          //                     Get.back();
          //                     Get.to(()=>CameraScreen());
          //                   },
          //                   child: Text("Image"),
          //                 ),
          //                 SizedBox(width: 5),
          //                 ElevatedButton(
          //                   onPressed: () {},
          //                   child: Text("Video"),
          //                 ),
          //                 SizedBox(width: 5),
          //                 ElevatedButton(
          //                   onPressed: () {},
          //                   child: Text("Text"),
          //                 ),
          //               ],
          //             ),
          //             IconButton(
          //               onPressed: () {},
          //               icon: Icon(
          //                 Icons.send,
          //                 color: Color(0xff00112B),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
