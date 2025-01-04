
import 'package:cloud_firestore/cloud_firestore.dart';


class Chat {
  String chatId;
  String lastMessage;
  DateTime lastMessageTime;
  DateTime createdAt;
  List<String> participants;
  Chat(
      {required this.chatId,
      required this.createdAt,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.participants});

  factory Chat.fromJson(Map<String,dynamic> doc) {
    return Chat(
      chatId: doc['chatId'],
      lastMessage: doc['lastMessage'],
      createdAt: (doc['createdAt'] as Timestamp).toDate(),
      lastMessageTime: (doc['lastMessageTime']as Timestamp).toDate(),
      participants: List<String>.from(doc['participants']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'lastMessage': lastMessage,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'participants': participants,
    };
  }
}
