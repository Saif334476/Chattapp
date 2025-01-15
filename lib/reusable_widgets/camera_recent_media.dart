import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import 'package:whatsapp_clone/reusable_widgets/camera_screen.dart';

class CameraAndMediaPicker extends StatefulWidget {
  @override
  _CameraAndMediaPickerState createState() => _CameraAndMediaPickerState();
}

class _CameraAndMediaPickerState extends State<CameraAndMediaPicker> {
  List<AssetEntity> recentMedia = [];
  late CameraController cameraController;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    fetchRecentMedia();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras[0],
          ResolutionPreset.high,
        );

        await cameraController.initialize();
        setState(() {
          isCameraInitialized = true;
        });
      } else {
        debugPrint('No cameras available');
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<void> fetchRecentMedia() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      final media = await PhotoManager.getAssetPathList(
        type: RequestType.common,
      );
      if (media.isNotEmpty) {
        final recent = await media[0].getAssetListPaged(page: 0, size: 100);
        setState(() {
          recentMedia = recent;
        });
      }
    } else {
      debugPrint('Permission denied to access media');
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BottomSheet(
      enableDrag: true,
      onClosing: () {},
      builder: (context) {
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                clipBehavior:Clip.hardEdge,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                ),
                itemCount: recentMedia.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () async{
                        final cameras = await availableCameras();
                        if (cameras.isNotEmpty) {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraScreen(recentMedia: recentMedia,
                                camera: cameras[0],
                              ),
                            ),
                          );

                          if (result != null) {
                            debugPrint('Captured image path: $result');
                            // You can handle the captured image here
                          }
                        }
                      },
                      child: Container(
                        color: Colors.blue,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                        alignment: Alignment.center,
                      ),
                    );
                  }
                  final mediaIndex = index - 1;
                  return FutureBuilder<Uint8List?>(
                    future: recentMedia[mediaIndex].thumbnailData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null) {
                        return GestureDetector(
                          onTap: () {
                            debugPrint(
                                'Selected media: ${recentMedia[mediaIndex]}');
                          },
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      return Container(color: Colors.grey);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    ));
  }
}
