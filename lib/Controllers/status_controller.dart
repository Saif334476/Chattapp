import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:whatsapp_clone/view/home/status/preview_status_by_cam.dart';

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

class StatusController extends GetxController {

  RxString currentMode = 'text'.obs;
  RxBool isRecording = false.obs;
  RxBool isVideoMode = false.obs;
  RxBool isFlashOn = false.obs;

  CameraController? cameraController;
  List<CameraDescription>? cameras;
  RxInt selectedCameraIndex = 0.obs;
  late Future<void> initializeControllerFuture;

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
  void changeMode(String mode) {
    currentMode.value = mode;
  }
  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        cameraController = CameraController(
          cameras![selectedCameraIndex.value],
          ResolutionPreset.high,
        );
        initializeControllerFuture = cameraController!.initialize();
        update();
      } else {
        print('No cameras found');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void toggleFlashlight() async {
    try {
      isFlashOn.value = !isFlashOn.value;
      await cameraController
          ?.setFlashMode(isFlashOn.value ? FlashMode.torch : FlashMode.off);
    } catch (e) {
      print("Error toggling flashlight: $e");
    }
  }

  void switchCamera() async {
    if (cameras == null || cameras!.isEmpty) return;

    await cameraController?.dispose();
    selectedCameraIndex.value = (selectedCameraIndex.value + 1) % cameras!.length;

    cameraController = CameraController(
      cameras![selectedCameraIndex.value],
      ResolutionPreset.high,
    );
    initializeControllerFuture = cameraController!.initialize();
    update();
  }

  Future<void> captureMedia(BuildContext context) async {
    try {
      if (isVideoMode.value) {
        if (isRecording.value) {
          final video = await cameraController?.stopVideoRecording();
          isRecording.value = false;
          Get.to(() => PreviewStatusByCam(captured: video?.path ?? ""));
        } else {
          await cameraController?.prepareForVideoRecording();
          await cameraController?.startVideoRecording();
          isRecording.value = true;
        }
      } else {
        final image = await cameraController?.takePicture();
        Get.to(() => PreviewStatusByCam(captured: image?.path));
      }
    } catch (e) {
      print("Error capturing media: $e");
      Get.snackbar('Error', 'Failed to capture media.');
    }
  }

  void toggleMode() {
    isVideoMode.value = !isVideoMode.value;
  }
}
