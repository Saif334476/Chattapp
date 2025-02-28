import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../reusable_widgets/custom_text_field.dart';
import '../../../../reusable_widgets/profile_pic_widget.dart';
import '../../chat/chat.dart';
import 'controller.dart';

class GroupDescription extends StatelessWidget {
  GroupDescription({super.key});
  final GroupCreationController controller =
      Get.put(GroupCreationController(), tag: "group");
  late final File? groupPhoto;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF388E3C),
          title: Text(
            "New group",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          scrolledUnderElevation: 2,
        ),
        body: Stack(children: [
          Container(color: Color(0xFF81C784).withOpacity(0.1)),
          Padding(
            padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: MediaQuery.sizeOf(context).height * 0.04),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  ProfilePicWidget(
                    onImagePicked: (imageUrl) {
                      groupPhoto = imageUrl;
                    },
                    uploadedProfileUrl: "",
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  textFormField(
                      "Group Name",
                      Icon(
                        Icons.group,
                        color: Color(0xFF388E3C),
                      ),
                      false,
                      keyboard: TextInputType.text,
                      controller: controller.groupName,
                      validator: (text) {
                    if (text!.isEmpty) {
                      return "Group name is required";
                    }
                    return null;
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Participants",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF388E3C),
                            fontSize: 18),
                      )),
                  Expanded(
                      child: GridView.builder(
                    itemCount: controller.selectedForGroup.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Card(
                            color: Color(0xFF91C784),
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Color(0xFF4CAF50))),
                                    height: 65,
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/person.webp",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 60,
                                      child: Text(
                                        controller.selectedForGroup[index].email,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 20,
                            child: GestureDetector(
                              onTap: () {
                                controller.selectedForGroup.removeAt(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4, // Adds depth
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                height: 22,
                                width: 22,
                                child: Icon(Icons.close,
                                    size: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF388E3C), // Matches the theme
              elevation: 2,
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.sendGreet();
                  Get.back();
                  Get.back();
                  Get.showSnackbar(
                    GetSnackBar(
                      title: "Success",
                      message: "Group is created",
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    ),
                  );

                  // Get.to(
                  //     () => ChatView(
                  //           id: controller.,
                  //           recipentsId: null,
                  //           type: "group",
                  //         ),
                  //     transition: Transition.leftToRightWithFade,
                  //     duration: Duration(milliseconds: 300));
                }
              },
              child: const Icon(
                Icons.done,
                color: Colors.white, // Blue accent color
                size: 30,
              ),
            ),
          ),
        ]));
  }
}
