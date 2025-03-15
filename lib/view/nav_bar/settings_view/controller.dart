import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isLoading = true.obs;
  var profilePicUrl = ''.obs;
  var userName = ''.obs;
  var statusMessage = ''.obs;
  File? profilePicFile;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {


      DocumentSnapshot userDoc = await _firestore.collection('Whatsapp Clone').doc("Data").collection("Users").doc(userId).get();

      if (userDoc.exists) {
        userName.value = userDoc['name'] ?? 'Your Name';
        statusMessage.value = userDoc['about'] ?? 'Hey there! I am using WhatsApp.';
        profilePicUrl.value = userDoc['profilePic'] ?? '';
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadProfilePic(File profilePicFile) async {
    try {
      isLoading.value = true;

      String fileExtension = profilePicFile.path.split('.').last;

      Reference ref = _storage.ref().child('profile_pics/$userId.$fileExtension');
      UploadTask uploadTask = ref.putFile(profilePicFile);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      profilePicUrl.value = downloadUrl;

      await _firestore.collection('Users').doc(userId).update({'profilePic': downloadUrl});
    } catch (e) {
      print("Error uploading profile picture: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
