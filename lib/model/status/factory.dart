// import 'package:whatsapp_clone/model/status/text.dart';
// import 'package:whatsapp_clone/model/status/image.dart';
// import 'package:whatsapp_clone/model/status/video.dart';
// import 'package:whatsapp_clone/model/status/abstract.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class StatusFactory {
//   static Status createStatus(Map<String, dynamic> data) {
//     final type = data['type'];
//     final timestamp = (data['timestamp'] as Timestamp).toDate(); // Convert Firestore Timestamp to DateTime
//     final viewedBy = List<String>.from(data['viewedBy'] ?? []);
//
//     switch (type) {
//       case "text":
//         return TextStatus(
//           text: data['text'],
//           timestamp: timestamp,
//           viewedBy: viewedBy,
//         );
//       case "image":
//         return ImageStatus(
//           imageUrl: data['url'],
//           timestamp: timestamp,
//           viewedBy: viewedBy,
//         );
//       case "video":
//         return VideoStatus(
//           videoUrl: data['url'],
//           timestamp: timestamp,
//           viewedBy: viewedBy,
//         );
//       default:
//         throw Exception("Unknown status type: $type");
//     }
//   }
// }
