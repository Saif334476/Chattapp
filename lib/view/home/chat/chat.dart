import 'package:flutter/material.dart';
import 'package:whatsapp_clone/reusable_widgets/reusable_widgets.dart';
import '../Widgets/message.dart';
import 'package:get/get.dart';
import '../../../Controllers/chat_controller.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key, required this.id, this.recipentsId,this.type})
      : controller = Get.put(ChatController(id, recipentsId,type),tag: id);

  final ChatController controller;
  final String id;
  final String? recipentsId;
  final String? type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey),
                height: 50,
                width: 50,
                child: ClipOval(
                    child: Image.asset(
                  "assets/person.webp",
                  fit: BoxFit.fill,
                ))),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  id,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,color: Colors.white,

                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.phone),color: Colors.white,)
            ],
          ),
          backgroundColor: const Color(0xFF388E3C),
        ),
        body: Obx(() {
          return
            Stack(children: [
              Container(color:Color(0xFF81C784).withOpacity(0.1),),

            Column(children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: controller.messages.isNotEmpty
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.messages.length,
                          itemBuilder: (context, index) {
                            return MessageView(
                                messageModeled: controller.messages[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 5);
                          },
                        )
                      : Center(child: Text('Conversation not started.'))),
            ),
            messageField(),
          ])]
          );
        }));
  }

  Widget messageField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: textFormField(
              maxLines: 3,
              suffixIcon: controller.isWriting.value
                  ? SizedBox(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.attach_file_outlined,color: Colors.white,)),
                    )
                  : SizedBox(
                      width: 97,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.attach_file_outlined),color: Color(0xFF388E3C)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.camera_alt),color: Color(0xFF388E3C)),
                        ],
                      ),
                    ),
              "",
              IconButton(
                icon: const Icon(Icons.emoji_emotions,color: Colors.yellow,),
                onPressed: () {
                  controller.isEmojiShowing.value =
                      !controller.isEmojiShowing.value;
                },
              ),
              false,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.isWriting.value = true;
                } else {
                  controller.isWriting.value = false;
                }
              },
              keyboard: TextInputType.text,
              controller: controller.messageController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a message';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child:  Container(
                decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF388E3C)),
                child: IconButton(
                  onPressed: () {
                    controller.sendMessage();
                  },
                  icon: controller.isWriting.value
                      ? const Icon(
                          Icons.send,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
