import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/reusable_widgets/reusable_widgets.dart';
import '../../../../reusable_widgets/custom_text_field.dart';
import '../../../../reusable_widgets/profile_pic_widget.dart';
import '../../chat/chat.dart';
import 'controller.dart';

class GroupDescription extends StatelessWidget {
  GroupDescription({super.key});
  final GroupCreationController controller =
      Get.put(GroupCreationController(), tag: "group");
  final TextEditingController text = TextEditingController();
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
                    controller: text, validator: (text) {
                  if (text!.isEmpty) {
                    return "Please enter name";
                  }
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
                    return Card(
                      color: Color(0xFF91C784),
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xFF4CAF50))),
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
                    );
                  },
                ))
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF388E3C), // Matches the theme
              elevation: 2,
              onPressed: () {
                controller.sendGreet();
                Get.back();
                Get.back();
                Get.to(
                    () => ChatView(
                          id: "chatIds",
                          recipentsId: null,
                          type: "group",
                        ),
                    transition: Transition.leftToRightWithFade,
                    duration: Duration(milliseconds: 300));
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
