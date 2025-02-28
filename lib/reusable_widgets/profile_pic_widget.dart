import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePicWidget extends StatefulWidget {
  final Function(File) onImagePicked;
  final String uploadedProfileUrl;

  const ProfilePicWidget({
    super.key,
    required this.onImagePicked,
    required this.uploadedProfileUrl,
  });

  @override
  ProfilePicWidgetState createState() => ProfilePicWidgetState();
}

class ProfilePicWidgetState extends State<ProfilePicWidget> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImagePicked(_imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(100),
            ),
            height: 100,
            width: 100,
            child: ClipOval(
              child: _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    )
                  : widget.uploadedProfileUrl.isNotEmpty
                      ? Image.network(
                          widget.uploadedProfileUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          "assets/person.webp",
                          fit: BoxFit.cover,
                        ),
            ),
          ),
        ),
        // Edit Button
        Positioned(
          left: 80,
          top: 10,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xFF388E3C),
            ),
            child: IconButton(
              padding: EdgeInsets.zero, // Removes extra padding
              onPressed: _pickImage,
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 18, // Reduced icon size
              ),
            ),
          ),
        ),
      ],
    );
  }
}
