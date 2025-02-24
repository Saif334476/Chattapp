import 'package:flutter/material.dart';
import '../../../model/message_model.dart';

class WhatsAppChatInput extends StatefulWidget {
  final List<MessageModel> messages;
  const WhatsAppChatInput({super.key, required this.messages});

  @override
  WhatsAppChatInputState createState() => WhatsAppChatInputState();
}

class WhatsAppChatInputState extends State<WhatsAppChatInput> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.emoji_emotions),
          onPressed: () {
          },
        ),
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Type a message',
            ),
            keyboardType: TextInputType.multiline,
            enableInteractiveSelection: true,
            textInputAction: TextInputAction.send,
            onSubmitted: (text) {
              widget.messages.add(
                MessageModel(
                  messageId: "1",
                  message: text,
                  senderId: "1111",
                  messageType: "text",
                  sentAt: DateTime.now(),
                  isDelivered: true,
                  isSeen: false,
                ),
              );
              _messageController.text = "";
              setState(() {});
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            widget.messages.add(
              MessageModel(
                messageId: "1",
                message: _messageController.text,
                senderId: "1111",
                messageType: "text",
                sentAt: DateTime.now(),
                isDelivered: true,
                isSeen: false,
              ),
            );
            _messageController.text = "";
            setState(() {});
          },
        ),
      ],
    );
  }
}
