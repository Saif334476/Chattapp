import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/reusable_widgets/camera_recent_media.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import 'package:whatsapp_clone/reusable_widgets/camera_screen.dart';

class StatusView extends StatefulWidget {
  const StatusView({super.key});

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  final picker = ImagePicker();
  List<AssetEntity> recentMedia = [];
  late CameraController cameraController;
  bool isCameraInitialized = false;
  final Set<int> selectedIndexes = {};

  @override
  void initState() {
    super.initState();
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
            onTap: () async {
              _showCameraBottomSheet(context);
            },
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
                        height: 25,
                        width: 25,
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
      ),
      Positioned(
        top: MediaQuery.of(context).size.height * 0.63,
        left: MediaQuery.of(context).size.width * 0.75,
        child: Column(children: [
         Material(
              color: Colors.transparent,
              elevation: 5,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Color(0xff00112B),
                ),
                // color: const Color(0xff4ECB5C),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.mode_edit_outlined,
                  size: 22,
                  color: Colors.white, // Icon color inside the filled container
                ),
              ),
            ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Adjust the border radius as needed
                ),
              ),
            ),
            onPressed: () {},
            child: Material(
              color: Colors.transparent,
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.zero)),
              elevation: 5,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Color(0xff00112B),
                ),
                // color: const Color(0xff4ECB5C),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.add_a_photo,
                  size: 30,
                  color: Colors.white, // Icon color inside the filled container
                ),
              ),
            ),
          ),
        ]),
      ),
    ]));
  }

  void _showCameraBottomSheet(BuildContext context) {
    initializeCamera();
    showModalBottomSheet(
      useSafeArea: true,
      enableDrag: true,
      clipBehavior: Clip.hardEdge,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // Initial height as a fraction of the screen
          minChildSize: 0.3, // Minimum height
          maxChildSize: 0.9, // Maximum height
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black, // Background of the bottom sheet
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Expanded(
                      child: GridView.builder(
                    controller:
                        scrollController, // Sync with the draggable sheet
                    clipBehavior: Clip.hardEdge,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                    ),
                    itemCount: recentMedia.length + 1,
                        itemBuilder: (context, index) {
                          final isSelected = selectedIndexes.contains(index);
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () async {
                                final cameras = await availableCameras();
                                if (cameras.isNotEmpty) {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CameraScreen(recentMedia:recentMedia
                                      ),
                                    ),
                                  );

                                  if (result != null) {
                                    debugPrint('Captured image path: $result');
                                  }
                                }
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt, color: Colors.deepOrangeAccent),
                                    Text("Camera",style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                                alignment: Alignment.center,
                              ),
                            );
                          }

                          final mediaIndex = index - 1;
                          final asset = recentMedia[mediaIndex];
                          return FutureBuilder<Uint8List?>(
                            future: asset.thumbnailData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done &&
                                  snapshot.data != null) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedIndexes.remove(index);
                                      } else {
                                        selectedIndexes.add(index);
                                      }
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.memory(
                                          snapshot.data!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 30,
                                          ),
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
                                  ),
                                );
                              }
                              return Container(color: Colors.grey);
                            },
                          );
                        },

                      )),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
