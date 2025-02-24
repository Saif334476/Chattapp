import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


class ColorController extends GetxController {
  final List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  var currentColor = Rx<Color>(Colors.red);

  void changeColor() {
    int currentIndex = colorList.indexOf(currentColor.value);
    int nextIndex = (currentIndex + 1) % colorList.length;
    currentColor.value = colorList[nextIndex];
  }
}


class StatusScreensControllers extends GetxController {
  RxString currentMode = 'image'.obs;
  final CameraScreenController cameraController = Get.isRegistered<CameraScreenController>()
      ? Get.find<CameraScreenController>()
      : Get.put(CameraScreenController());

  void changeMode(String mode) {
    if ((currentMode.value == 'image' || currentMode.value == 'video') && (mode == "image" || mode == "video")) {
      currentMode.value = mode;
    } else if ((currentMode.value == 'image' || currentMode.value == "video") && mode == "text") {
     // cameraController.pauseCamera();
      currentMode.value = mode;
    } else if (currentMode.value == 'text' && (mode == "image" || mode == "video")) {
     // cameraController.resumeCamera();
      currentMode.value = mode;

    }
  }
}

class CameraScreenController extends GetxController {
  RxBool isCameraInitialized = false.obs;
  CameraController? cameraController;
  List<CameraDescription> cameras=[];
  RxInt selectedCameraIndex = 0.obs;
  RxBool isFlashOn = false.obs;


  @override
  void onInit() {
    super.onInit();
    initializeCamera();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  }

  @override
  void onClose() {
    disposeCamera();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.onClose();
  }
  Future<void> disposeCamera() async {
    if (cameraController != null) {
      await cameraController!.dispose();
      cameraController = null;
      isCameraInitialized.value = false;
    }
  }
  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras[selectedCameraIndex.value],
          ResolutionPreset.high,
        );
        await cameraController!.initialize();
        isCameraInitialized.value = true;
      }
    } catch (e) {
      print("Camera initialization error: $e");
      isCameraInitialized.value = false;
    }
  }


  void toggleFlashlight() {
    if (cameraController != null) {
      isFlashOn.value = !isFlashOn.value;
      cameraController!.setFlashMode(isFlashOn.value ? FlashMode.torch : FlashMode.off);
    }
  }

  // Future<void> switchCamera() async {
  //   if (cameras.isEmpty) return;
  //
  //   selectedCameraIndex.value = (selectedCameraIndex.value + 1) % cameras.length;
  //   await cameraController?.dispose();
  //   isCameraInitialized.value = false;
  //   await initializeCamera();
  // }
  Future<void> switchCamera() async {
    if (cameras.isEmpty) return;

    // Dispose old camera before switching
    await disposeCamera();

    selectedCameraIndex.value = (selectedCameraIndex.value + 1) % cameras.length;

    // Wait a bit before reinitializing to prevent race conditions
    Future.delayed(Duration(milliseconds: 100), () async {
      await initializeCamera();
    });
  }
  Future<void> captureMedia(BuildContext context) async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      try {
        XFile file = await cameraController!.takePicture();
        print("Picture taken: ${file.path}");
      } catch (e) {
        print("Error capturing media: $e");
      }
    }
  }
}

