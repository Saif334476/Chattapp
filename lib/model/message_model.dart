import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String message;
  final String senderId;
  final String messageType;
  final DateTime sentAt;
  final bool isDelivered;
  final bool isSeen;


  MessageModel({
    required this.messageId,
    required this.message,
    required this.senderId,
    required this.messageType,
    required this.sentAt,
    required this.isDelivered,
    required this.isSeen,
  });


  factory MessageModel.fromJson(Map<String,dynamic> doc) {
    return MessageModel(
      messageId: doc['messageId'],
      message: doc['message'],
      senderId: doc['senderId'],
      messageType: doc['messageType'],
      sentAt: (doc['sentAt'] as Timestamp).toDate(),
      isDelivered: doc['isDelivered'],
      isSeen: doc['isSeen'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'message': message,
      'senderId': senderId,
      'messageType': messageType,
      'sentAt': sentAt,
      'isDelivered': isDelivered,
      'isSeen': isSeen,


    };
  }
}
