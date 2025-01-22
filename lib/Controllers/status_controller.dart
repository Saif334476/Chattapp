import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ColorController extends GetxController {
  // Define a list of colors
  final List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  // Create an Rx variable to manage the current color
  var currentColor = Rx<Color>(Colors.red);

  // Method to change the color
  void changeColor() {
    int currentIndex = colorList.indexOf(currentColor.value);
    int nextIndex = (currentIndex + 1) % colorList.length;
    currentColor.value = colorList[nextIndex];
  }
}
