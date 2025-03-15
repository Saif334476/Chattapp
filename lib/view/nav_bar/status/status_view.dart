import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';
import 'package:whatsapp_clone/Controllers/status_controller.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/reusable_widgets/camera_screen.dart';

import '../../../theme/theme_controller.dart';

class StatusView extends StatefulWidget {
  const StatusView({super.key});

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  final ThemeController themeController = Get.find();
  final picker = ImagePicker();
  List<AssetEntity> recentMedia = [];
  //late CameraController cameraController;
  //bool isCameraInitialized = false;
  final Set<int> selectedIndexes = {};
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    fetchRecentMedia();
    scrollController = ScrollController();
  }

  // Future<void> initializeCamera() async {
  //   try {
  //     final cameras = await availableCameras();
  //     if (cameras.isNotEmpty) {
  //       cameraController = CameraController(
  //         cameras[0],
  //         ResolutionPreset.high,
  //       );
  //
  //       await cameraController.initialize();
  //       setState(() {
  //         isCameraInitialized = true;
  //       });
  //     } else {
  //       debugPrint('No cameras available');
  //     }
  //   } catch (e) {
  //     debugPrint('Error initializing camera: $e');
  //   }
  // }

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
  //
  // @override
  // void dispose() {
  //   cameraController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Container(color: Color(0xFF81C784).withOpacity(0.1)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.09,
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 15),
          //   child: Text(
          //     "Status",
          //     style: TextStyle(
          //         color: Color(0xFF2C6B39),
          //         fontWeight: FontWeight.w900,
          //         fontSize: 18),
          //   ),
          // ),
          InkWell(
            onTap: () {},
            child: Card(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: ListTile(
                onTap: () {
                  _showRecentItems();
                },
                leading: Stack(children: [
                  Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF2C6B39)),
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.transparent),
                      height: 50,
                      width: 50,
                      child: ClipOval(
                          child: Image.asset(
                        "assets/person.webp",
                        fit: BoxFit.fill,
                      ))),
                  Obx(() => Positioned(
                        bottom: 0,
                        right: 0,
                        child: Transform.translate(
                          offset: Offset(5, 5), // Adjust position slightly
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: themeController.isDarkMode.value
                                  ? Colors.grey[800]
                                  : Color(0xFF388E3C),
                              border: Border.all(color: Color(0xFF2C6B39)),
                            ),
                            child: Center(
                              // Ensure the icon is centered
                              child: Icon(
                                Icons.add,
                                size: 14, // Adjust size if needed
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ))
                ]),
                title: Text(
                  "My Status",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text("Tap to add status update"),
              ),
            ),
          ),
          // ListTile(
          //   onTap: () async {
          //     _showRecentItems();
          //   },
          //   leading: Stack(children: [
          //     Container(
          //         padding: EdgeInsets.all(1),
          //         decoration: BoxDecoration(
          //             border: Border.all(color: Color(0xff00112B)),
          //             borderRadius: BorderRadius.circular(100),
          //             color: Colors.transparent),
          //         height: 50,
          //         width: 50,
          //         child: ClipOval(
          //             child: Image.asset(
          //           "assets/person.webp",
          //           fit: BoxFit.fill,
          //         ))),
          //     Positioned(
          //         bottom: 0,
          //         right: 0,
          //         child: Transform.translate(
          //           offset: Offset(5, 5), // Adjust the position of the button
          //           child: Container(
          //               height: 25,
          //               width: 25,
          //               decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   color: Color(0xff00112B),
          //                   border: Border.all(color: Color(0xff00112B))),
          //               child: IconButton(
          //                   onPressed: () {},
          //                   icon: Icon(
          //                     Icons.add,
          //                     size: 10,
          //                     color: Colors.white,
          //                   ))),
          //         ))
          //   ]),
          //   title: Text(
          //     "My status",
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   subtitle: Text(
          //     "Tap to add status update",
          //     style: TextStyle(color: Colors.white70),
          //   ),
          // ),
          Container(
              padding: EdgeInsets.only(left: 15, top: 5),
              child: Text(
                "Recent Updates",
                style: Theme.of(context).textTheme.titleSmall,
              ))
        ],
      ),
      Obx(() => Positioned(
            top: MediaQuery.of(context).size.height * 0.63,
            left: MediaQuery.of(context).size.width * 0.8,
            child: Column(children: [
              GestureDetector(
                  onTap: () {
                    final StatusScreensControllers statusController =
                        Get.isRegistered<StatusScreensControllers>()
                            ? Get.find<StatusScreensControllers>()
                            : Get.put(StatusScreensControllers());
                    statusController.currentMode.value = "text";
                    Get.to(() => StatusScreen());
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: themeController.isDarkMode.value
                            ? Colors.grey[800] // Dark Mode Color
                            : Color(0xFF388E3C),
                      ),
                      // color: const Color(0xff4ECB5C),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.mode_edit_outlined,
                        size: 22,
                        color: Colors
                            .white, // Icon color inside the filled container
                      ),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  // _showCameraBottomSheet(context);
                  _showRecentItems();
                },
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: themeController.isDarkMode.value
                          ? Colors.grey[800] // Dark Mode Color
                          : Color(0xFF388E3C),
                    ),
                    // color: const Color(0xff4ECB5C),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.add_a_photo,
                      size: 30,
                      color: Colors
                          .white, // Icon color inside the filled container
                    ),
                  ),
                ),
              )
            ]),
          )),
    ])));
  }

  void _showRecentItems() {
    Get.bottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.black, // Background of the bottom sheet
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
                controller: scrollController,
                clipBehavior: Clip.hardEdge,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                ),
                itemCount: recentMedia.length + 1,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndexes.contains(index);
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => StatusScreen());
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt,
                                color: Colors.deepOrangeAccent),
                            Text(
                              "Camera",
                              style: TextStyle(color: Colors.white),
                            ),
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
        ));
  }
}
