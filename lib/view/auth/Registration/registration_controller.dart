import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login.dart';

class RegistrationController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutMessageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  var credentials;
  var confirmObscured = true.obs;
  var createObscured = true.obs;
  var isLoading = false.obs;
  File? profilePicFile;

  void toggleCreatePasswordVisibility() {
    createObscured.value = !createObscured.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmObscured.value = !confirmObscured.value;
  }

  void setProfilePic(File? image) {
    profilePicFile = image;
    update();
  }

  Future<String?> uploadProfilePic(File profilePicFile, String userId) async {
    try {
      String fileExtension = profilePicFile.path.split('.').last;
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('profile_pics')
          .child('$userId.$fileExtension');

      UploadTask uploadTask = ref.putFile(profilePicFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('Whatsapp Clone')
          .doc("Data")
          .collection("Users")
          .doc(userId)
          .update({
        'profilePic': downloadUrl,
      });

      return downloadUrl;
    } catch (e) {
      Get.snackbar("Upload Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return null;
    }
  }

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
       credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: confirmPasswordController.text,
      );

      await FirebaseFirestore.instance
          .collection('Whatsapp Clone')
          .doc("Data")
          .collection("Users")
          .doc(credentials.user?.uid)
          .set({
        'name': nameController.text,
        'email': emailController.text,
        'about': aboutMessageController.text
      }, SetOptions(merge: true));

      isLoading.value = false;
      Get.offAll(() => const LoginView());
    } catch (error) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );
    }
    if(profilePicFile!=null){
    uploadProfilePic(profilePicFile!, credentials.user?.uid);
  }}
}
