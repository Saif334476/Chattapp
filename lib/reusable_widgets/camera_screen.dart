import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:whatsapp_clone/reusable_widgets/preview_screen.dart';
import 'package:whatsapp_clone/view/home/status/preview_status_by_cam.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;
  final List<AssetEntity> recentMedia;

  CameraScreen({required this.camera, required this.recentMedia});

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

    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _cameraController.initialize();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras(); // Get available cameras.
    if (cameras != null && cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras![selectedCameraIndex],
        ResolutionPreset.high,
      );
      await _cameraController.initialize();
      setState(() {}); // Refresh the UI after camera initialization.
    } else {
      print('No cameras found');
    }
  }

  Future<void> _switchCamera() async {
    if (cameras == null || cameras!.isEmpty) return;

    selectedCameraIndex =
        (selectedCameraIndex + 1) % cameras!.length; // Toggle index.
    await _cameraController.dispose(); // Dispose of the current controller.

    _cameraController = CameraController(
      cameras![selectedCameraIndex],
      ResolutionPreset.high,
    );

    await _cameraController.initialize();
    setState(() {}); // Refresh UI with the new camera.
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
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.87,
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: _cameraController.value.aspectRatio,
                    child: CameraPreview(_cameraController),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 10,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff1A2941),
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 100,
                  left: 10,
                  right: 10,
                  child: SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final asset = widget.recentMedia[index];
                        return FutureBuilder<Uint8List?>(
                          future: asset.thumbnailDataWithSize(
                            ThumbnailSize(70, 70),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return Stack(
                                children: [
                                  // Display thumbnail
                                  Image.memory(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                  if (asset.type == AssetType.video)
                                    Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              );
                            }
                            return Container(
                              width: 70,
                              height: 70,
                              color: Colors.grey.shade300,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(width: 5),
                      itemCount: widget.recentMedia.length,
                    ),
                  ),
                ),
                // Flashlight Button
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  right: 10,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff1A2941),
                    onPressed: _toggleFlashlight,
                    child: Icon(
                      isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: isFlashOn ? Colors.white : Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
                // Toggle Mode Button
                Positioned(
                  bottom: MediaQuery.sizeOf(context).height * 0.03,
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
                  bottom: MediaQuery.sizeOf(context).height * 0.03,
                  right: 10,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff1A2941),
                    onPressed: () {
                      _switchCamera();
                    },
                    child: Icon(
                      Icons.autorenew_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.sizeOf(context).height * 0.02,
                  right: MediaQuery.of(context).size.width * 0.4,
                  child: IconButton(
                    onPressed: _captureMedia,
                    icon: Icon(
                      isVideoMode
                          ? (isRecording
                              ? Icons.stop_circle
                              : Icons.circle_outlined)
                          : Icons.camera_alt,
                      color: isVideoMode && isRecording
                          ? Colors.red
                          : Colors.lightBlue,
                      size: 60,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
