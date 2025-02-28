import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Controllers/contact_list_controller.dart';

import 'controller.dart';
import 'group_description.dart';

class CreateGroup extends StatelessWidget {
  const CreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupCreationController controller =
        Get.put(GroupCreationController(), tag: "group");
    final ContactListController contactController =
        Get.put(ContactListController());

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          Get.delete<GroupCreationController>(tag: "group");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.delete<GroupCreationController>(tag: "group");
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF388E3C),
          title: ListTile(
            title: Text(
              "New group",
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
            ),
            subtitle: Text(
              "Add members",
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                )),
          ),
          scrolledUnderElevation: 2,
        ),
        body: Obx(() {
          if (contactController.contactList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(children: [
            Container(color: Color(0xFF81C784).withOpacity(0.1)),
            Column(
              children: [
                controller.selectedForGroup.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 90,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Card(
                                        color: Color(0xFF91C784),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFF4CAF50))),
                                                height: 45,
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    "assets/person.webp",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: 60,
                                                  child: Text(
                                                    controller
                                                        .selectedForGroup[index]
                                                        .email,
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
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
                                            child: Icon(Icons.close, size: 14, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Container();
                                },
                                itemCount: controller.selectedForGroup.length),
                          ),
                          Divider(
                            color: Colors.grey,
                          )
                        ],
                      )
                    : Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF388E3C)
                                  .withOpacity(0.2), // Shadow color
                              spreadRadius: 1, // How much the shadow spreads
                              blurRadius: 6, // Blurriness of the shadow
                              offset: Offset(2,
                                  4), // X (right) & Y (down) shadow positioning
                            ),
                          ],
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                                color: Color(0xFF388E3C),
                                width: MediaQuery.sizeOf(context).width * 0.02),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.1,
                              child: Image.asset(
                                "assets/tap.png",
                                color: Color(0xFF388E3C),
                              ),
                            ),
                            Text(
                              "Tap to select contacts from below",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF388E3C),
                                  fontSize: 15),
                            ),
                          ],
                        )),
                Expanded(
                  child: ListView.separated(
                    itemCount: contactController.contactList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final contact = contactController.contactList[index];
                      final bool isSelected =
                          controller.selectedForGroup.contains(contact);

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        // color: isSelected
                        //     ? Color(0xFF81C784)
                        //     : Colors.white,
                        child: ListTile(
                          trailing: isSelected
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : null,
                          onTap: () async {
                            if (!isSelected) {
                              controller.selectedForGroup.add(contact);
                            } else {
                              controller.selectedForGroup.remove(contact);
                            }
                          },
                          leading: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.transparent,
                            ),
                            height: 50,
                            width: 50,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/person.webp",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              contact.email,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container();
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF388E3C), // Matches the theme
                elevation: 2,
                onPressed: () {
                  Get.to(() => GroupDescription(),
                      transition: Transition.leftToRightWithFade,
                      duration: Duration(milliseconds: 300));
                },
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white, // Blue accent color
                  size: 30,
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
