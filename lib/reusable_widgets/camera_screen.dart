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

class CameraScreen extends StatefulWidget {
  final List<AssetEntity> recentMedia;

  CameraScreen({required this.recentMedia});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  List<CameraDescription>? cameras;
  int selectedCameraIndex = 0;
  late Future<void> _initializeControllerFuture;
  bool isFlashOn = false;
  bool isRecording = false;
  bool isVideoMode = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        _cameraController = CameraController(
          cameras![selectedCameraIndex],
          ResolutionPreset.high,
        );
        _initializeControllerFuture = _cameraController.initialize();
        setState(() {});
      } else {
        print('No cameras found');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (cameras == null || cameras!.isEmpty) return;

    await _cameraController.dispose();
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;

    _cameraController = CameraController(
      cameras![selectedCameraIndex],
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  void _toggleFlashlight() async {
    try {
      isFlashOn = !isFlashOn;
      await _cameraController
          .setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
      setState(() {});
    } catch (e) {
      print("Error toggling flashlight: $e");
    }
  }

  Future<void> _captureMedia() async {
    try {
      if (isVideoMode) {
        if (isRecording) {
          final video = await _cameraController.stopVideoRecording();
          setState(() {
            isRecording = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreviewStatusByCam(captured: video.path),
            ),
          );
        } else {
          await _cameraController.prepareForVideoRecording();
          await _cameraController.startVideoRecording();
          setState(() {
            isRecording = true;
          });
        }
      } else {
        final image = await _cameraController.takePicture();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewStatusByCam(captured: image.path),
          ),
        );
      }
    } catch (e) {
      print("Error capturing media: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to capture media.')),
      );
    }
  }

  void _toggleMode() {
    setState(() {
      isVideoMode = !isVideoMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
        body: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(children: [
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
                            aspectRatio: _cameraController.value.aspectRatio,
                            child: CameraPreview(_cameraController),
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
                            onPressed: _toggleFlashlight,
                            child: Icon(
                              isFlashOn ? Icons.flash_on : Icons.flash_off,
                              color: isFlashOn ? Colors.white : Colors.grey,
                              size: 25,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: mediaSize.height * 0.03,
                          left: 10,
                          child: FloatingActionButton(
                            backgroundColor: Color(0xff1A2941),
                            onPressed: _toggleMode,
                            child: Icon(
                              isVideoMode ? Icons.camera : Icons.videocam,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: mediaSize.height * 0.03,
                          right: 10,
                          child: FloatingActionButton(
                            backgroundColor: Color(0xff1A2941),
                            onPressed: _switchCamera,
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
                            onPressed: _captureMedia,
                            icon: Icon(
                              isVideoMode
                                  ? (isRecording
                                      ? Icons.videocam_outlined
                                      : Icons.circle_outlined)
                                  : Icons.circle_outlined,
                              color: isVideoMode && isRecording
                                  ? Colors.white
                                  : Colors.white,
                              size: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.025,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildOptionButton("Text", () {
                            Get.to((() => TextStatusScreen()));
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          _buildOptionButton("Image", () {
                            Get.to((() => TextStatusScreen()));
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          _buildOptionButton("Video", () {
                            Get.to((() => TextStatusScreen()));
                          }),
                        ],
                      ),
                    )
                  ])
                ]);
              } else {
                return Container();
              }
            }));
  }

  Widget _buildOptionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }
}
