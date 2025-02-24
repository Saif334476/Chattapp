import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import '../view/nav_bar/status/text_status.dart';
import 'reusable_widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:whatsapp_clone/Controllers/status_controller.dart';


class CameraScreen extends StatelessWidget {
  final CameraScreenController cameraController =
  Get.isRegistered<CameraScreenController>()
      ? Get.find<CameraScreenController>()
      : Get.put(CameraScreenController());

  final StatusScreensControllers statusControllerSc =
  Get.isRegistered<StatusScreensControllers>()
      ? Get.find<StatusScreensControllers>()
      : Get.put(StatusScreensControllers());

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        if (!cameraController.isCameraInitialized.value) {
          return Center(child: Container(color: Colors.black,));
        }

        return Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              color: Colors.black,
            ),
            Column(
              children: [
                SizedBox(height: mediaSize.height * 0.1),
                Stack(
                  children: [
                    // Camera Preview
                    cameraController.cameraController != null &&
                        cameraController.cameraController!.value.isInitialized
                        ? SizedBox(
                      height: mediaSize.height * 0.8,
                      width: mediaSize.width,
                      child: AspectRatio(
                        aspectRatio: cameraController.cameraController!.value.aspectRatio,
                          child: CameraPreview(cameraController.cameraController!),
                        )

                    )
                        : Center(
                      child: Text("Camera not initialized", style: TextStyle(color: Colors.white)),
                    ),

                    // Close Button
                    Positioned(
                      top: mediaSize.height * 0.03,
                      left: 10,
                      child: iconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: Colors.white, size: 25),
                      ),
                    ),

                    // 🔽🔽 Commented Code: Recent Media List 🔽🔽
                    // Positioned(
                    //   bottom: 100,
                    //   left: 10,
                    //   right: 10,
                    //   child: SizedBox(
                    //     height: 60,
                    //     child: ListView.separated(
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         final asset = widget.recentMedia[index];
                    //         return FutureBuilder<Uint8List?>(
                    //           future: asset.thumbnailDataWithSize(
                    //             ThumbnailSize(60, 60),
                    //           ),
                    //           builder: (context, snapshot) {
                    //             if (snapshot.connectionState == ConnectionState.done &&
                    //                 snapshot.data != null) {
                    //               return Container(
                    //                 decoration: BoxDecoration(
                    //                   border: Border.all(
                    //                     color: Colors.white,
                    //                     width: 2,
                    //                   ),
                    //                   borderRadius: BorderRadius.circular(8),
                    //                   boxShadow: [
                    //                     BoxShadow(
                    //                       color: Colors.black26,
                    //                       blurRadius: 4,
                    //                       offset: Offset(0, 2),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 child: Stack(
                    //                   children: [
                    //                     ClipRRect(
                    //                       borderRadius: BorderRadius.circular(8),
                    //                       child: Image.memory(
                    //                         snapshot.data!,
                    //                         fit: BoxFit.cover,
                    //                         width: 60,
                    //                         height: 60,
                    //                       ),
                    //                     ),
                    //                     if (asset.type == AssetType.video)
                    //                       Align(
                    //                         alignment: Alignment.center,
                    //                         child: Icon(
                    //                           Icons.play_circle_outline,
                    //                           size: 30,
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                   ],
                    //                 ),
                    //               );
                    //             }
                    //             return Container(
                    //               width: 80,
                    //               height: 80,
                    //               color: Colors.grey.shade300,
                    //               child: Center(
                    //                 child: CircularProgressIndicator(),
                    //               ),
                    //             );
                    //           },
                    //         );
                    //       },
                    //       separatorBuilder: (context, index) => SizedBox(width: 5),
                    //       itemCount: widget.recentMedia.length,
                    //     ),
                    //   ),
                    // ),

                    // Flash Toggle Button
                    Positioned(
                      top: mediaSize.height * 0.03,
                      right: 10,
                      child: iconButton(
                        onPressed: () => cameraController.toggleFlashlight(),
                        icon: Icon(
                          cameraController.isFlashOn.value ? Icons.flash_on : Icons.flash_off,
                          color: cameraController.isFlashOn.value ? Colors.white : Colors.grey,
                          size: 30,
                        ),
                      ),
                    ),

                    // Toggle Media Mode Button (Switch between Photo & Video)
                    Positioned(
                      bottom: mediaSize.height * 0.03,
                      left: 10,
                      child: iconButton(
                        onPressed: () {
                        },
                        icon: Icon(Icons.image, color: Colors.white),
                      ),
                    ),

                    // Switch Camera Button
                    Positioned(
                      bottom: mediaSize.height * 0.03,
                      right: 10,
                      child: iconButton(
                        onPressed: () => cameraController.switchCamera(),
                        icon: Icon(Icons.autorenew_rounded, color: Colors.white),
                      ),
                    ),

                    // Capture Button (Photo/Video)
                    Positioned(
                      bottom: mediaSize.height * 0.02,
                      right: mediaSize.width * 0.4,
                      child: InkWell(
                        onTap: () => cameraController.captureMedia(context),
                        child: statusControllerSc.currentMode == "video"
                            ? Stack(
                          alignment: Alignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.circle_outlined, size: 80, color: Colors.grey),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.fiber_manual_record, size: 30, color: Colors.red),
                            ),
                          ],
                        )
                            : IconButton(
                          onPressed: () {
                            cameraController.cameraController?.dispose();
                            cameraController.captureMedia(context);
                          },
                          icon: Icon(Icons.circle_outlined, size: 80, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}


class StatusScreen extends StatelessWidget {
  final StatusScreensControllers statusScreensController =
      Get.isRegistered<StatusScreensControllers>()
          ? Get.find<StatusScreensControllers>()
          : Get.put(StatusScreensControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              switch (statusScreensController.currentMode.value) {
                case 'text':
                  return TextStatusScreen();
                case 'image':
                  return CameraScreen();
                case 'video':
                  return CameraScreen();
                default:
                  return Center(child: Text('Invalid Mode'));
              }
            }),
          ),
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child:
                  //Row(children: [
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ModeButton(mode: 'video', label: 'Video'),
                  SizedBox(width: 10),
                  ModeButton(mode: 'image', label: 'Image'),
                  SizedBox(width: 10),
                  ModeButton(mode: 'text', label: 'Text'),
                ],
              ),
              //   statusScreensController.currentMode.value == "text"
              //       ? textButton(
              //           text: Icon(
              //             Icons.send,
              //             color: Colors.black,
              //           ),
              //           onPressed: () {
              //
              //           })
              //       : Container()
              // ])
            );
          })
        ],
      ),
    );
  }
}

class ModeButton extends StatelessWidget {
  final String mode;
  final String label;

  ModeButton({required this.mode, required this.label});

  @override
  Widget build(BuildContext context) {
    final StatusScreensControllers statusScreensController =
        Get.isRegistered<StatusScreensControllers>()
            ? Get.find<StatusScreensControllers>()
            : Get.put(StatusScreensControllers());

    return Obx(() {
      bool isSelected = statusScreensController.currentMode.value == mode;

      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey,
        ),
        onPressed: () => statusScreensController.changeMode(mode),
        child: Text(label, style: TextStyle(color: Colors.white)),
      );
    });
  }
}
