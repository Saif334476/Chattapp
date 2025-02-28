import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/message_model.dart';

class MessageView extends StatelessWidget {
  const MessageView(
      {super.key, required this.messageModeled, required this.type});
  final String? type;
  final MessageModel messageModeled;

  @override
  Widget build(BuildContext context) {
    bool isMe =
        messageModeled.senderId == FirebaseAuth.instance.currentUser?.uid;
    //  bool isSystem = messageModeled.senderId == "System";
    return messageModeled.senderId == "System"
        ? Align(
            alignment: Alignment.center,
            child: IntrinsicWidth(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                decoration: BoxDecoration(
                    color: Color(0xFF81C784).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messageModeled.message,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      // textAlign: isMe ? TextAlign.end : TextAlign.start,
                      softWrap: true,
                      maxLines: null,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     // if (isMe)
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       DateFormat("hh:mm").format(
                    //         messageModeled.sentAt.toLocal(),
                    //       ),
                    //       style: const TextStyle(fontSize: 10),
                    //     ),
                    //     isMe
                    //         ? Icon(
                    //       messageModeled.isDelivered
                    //           ? Icons.done_all
                    //           : Icons.done,
                    //       size: 14,
                    //       color: messageModeled.isSeen
                    //           ? Colors.blueAccent
                    //           : Colors.black,
                    //     )
                    //         : Container()
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          )
        : type == "Group"
            ? Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: IntrinsicWidth(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                        color: isMe ? Colors.grey : Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10),
                            topRight: const Radius.circular(10),
                            bottomLeft: Radius.circular(isMe ? 10 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 10))),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        !isMe
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [Text(messageModeled.senderId,style: TextStyle(fontSize: 10),),
                                  SizedBox(width: 5,),
                                  Text("Name",style: TextStyle(fontSize: 10),)],
                              )
                            : Container(),
                        Text(
                          messageModeled.message,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: isMe ? TextAlign.end : TextAlign.start,
                          softWrap: true,
                          maxLines: null,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // if (isMe)
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              DateFormat("hh:mm").format(
                                messageModeled.sentAt.toLocal(),
                              ),
                              style: const TextStyle(fontSize: 10),
                            ),
                            isMe
                                ? Icon(
                                    messageModeled.isDelivered
                                        ? Icons.done_all
                                        : Icons.done,
                                    size: 14,
                                    color: messageModeled.isSeen
                                        ? Colors.blueAccent
                                        : Colors.black,
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: IntrinsicWidth(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                        color: isMe ? Colors.grey : Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10),
                            topRight: const Radius.circular(10),
                            bottomLeft: Radius.circular(isMe ? 10 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 10))),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          messageModeled.message,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: isMe ? TextAlign.end : TextAlign.start,
                          softWrap: true,
                          maxLines: null,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // if (isMe)
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              DateFormat("hh:mm").format(
                                messageModeled.sentAt.toLocal(),
                              ),
                              style: const TextStyle(fontSize: 10),
                            ),
                            isMe
                                ? Icon(
                                    messageModeled.isDelivered
                                        ? Icons.done_all
                                        : Icons.done,
                                    size: 14,
                                    color: messageModeled.isSeen
                                        ? Colors.blueAccent
                                        : Colors.black,
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
