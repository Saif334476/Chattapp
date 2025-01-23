import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'package:whatsapp_clone/view/home/status/text_status.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:whatsapp_clone/reusable_widgets/preview_screen.dart';
import 'package:whatsapp_clone/view/home/status/preview_status_by_cam.dart';
import 'reusable_widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:whatsapp_clone/Controllers/status_controller.dart';

class CameraScreen extends StatelessWidget {
  final StatusController statusController = Get.put(StatusController());
  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
        body:
        FutureBuilder<void>(
            future: statusController.initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx((){return Stack(children: [
                  Container(
                    color: Colors.black,
                  ),
                  Column(children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.08,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: mediaSize.height * 0.8,
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: statusController
                                .cameraController!.value.aspectRatio,
                            child: CameraPreview(
                                statusController.cameraController!),
                          ),
                        ),
                        Positioned(
                          top: mediaSize.height * 0.03,
                          left: 10,
                          child: FloatingActionButton(
                            backgroundColor: Color(0xff1A2941),
                            onPressed: () => Navigator.pop(context),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
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
                        //             if (snapshot.connectionState ==
                        //                     ConnectionState.done &&
                        //                 snapshot.data != null) {
                        //               return Container(
                        //                 decoration: BoxDecoration(
                        //                   border: Border.all(
                        //                     color: Colors.white,
                        //                     width: 2,
                        //                   ),
                        //                   borderRadius:
                        //                       BorderRadius.circular(8),
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
                        //                       borderRadius:
                        //                           BorderRadius.circular(8),
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
                        //       separatorBuilder: (context, index) =>
                        //           SizedBox(width: 5),
                        //       itemCount: widget.recentMedia.length,
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          top: mediaSize.height * 0.03,
                          right: 10,
                          child: FloatingActionButton(
                            backgroundColor: Color(0xff1A2941),
                            onPressed:(){ statusController.toggleFlashlight();},
                            child: Icon(
                              statusController.isFlashOn.value
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                              color: statusController.isFlashOn.value
                                  ? Colors.white
                                  : Colors.grey,
                              size: 25,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: mediaSize.height * 0.03,
                          left: 10,
                          child: FloatingActionButton(
                            backgroundColor: Color(0xff1A2941),
                            onPressed: (){statusController.toggleMode();},
                            child: Icon(
                              statusController.isVideoMode.value
                                  ? Icons.camera
                                  : Icons.videocam,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: mediaSize.height * 0.03,
                          right: 10,
                          child: FloatingActionButton(
                            backgroundColor: Color(0xff1A2941),
                            onPressed: statusController.switchCamera,
                            child: Icon(
                              Icons.autorenew_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: mediaSize.height * 0.02,
                          right: mediaSize.width * 0.4,
                          child: IconButton(
                            onPressed: () async {
                              await statusController.captureMedia(context);
                            },
                            icon: Icon(
                              statusController.isVideoMode.value
                                  ? (statusController.isRecording.value
                                      ? Icons.videocam_outlined
                                      : Icons.circle_outlined)
                                  : Icons.circle_outlined,
                              color: statusController.isVideoMode.value &&
                                      statusController.isRecording.value
                                  ? Colors.white
                                  : Colors.white,
                              size: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: MediaQuery.sizeOf(context).height * 0.025,
                    // ),
                    // Container(
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       _buildOptionButton("Text", () {
                    //         Get.to((() => TextStatusScreen()));
                    //       }),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       _buildOptionButton("Image", () {
                    //         Get.to((() => TextStatusScreen()));
                    //       }),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       _buildOptionButton("Video", () {
                    //         Get.to((() => TextStatusScreen()));
                    //       }),
                    //     ],
                    //   ),
                    // )
                  ])
                ]);});
              } else {
                return Container();
              }
  })
    );
  }
}

class StatusScreen extends StatelessWidget {
  final StatusController statusController = Get.put(StatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              switch (statusController.currentMode.value) {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ModeButton(mode: 'video', label: 'Video'),
                  SizedBox(width: 10),
                  ModeButton(mode: 'image', label: 'Image'),
                  SizedBox(width: 10),
                  ModeButton(mode: 'text', label: 'Text'),
                ],
              ),
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
    final StatusController statusController = Get.find();

    return Obx(() {
      bool isSelected = statusController.currentMode.value == mode;

      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey,
        ),
        onPressed: () => statusController.changeMode(mode),
        child: Text(label, style: TextStyle(color: Colors.white)),
      );
    });
  }
}
