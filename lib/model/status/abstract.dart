import'package:whatsapp_clone/model/status/text.dart';
import'package:whatsapp_clone/model/status/image.dart';
import'package:whatsapp_clone/model/status/video.dart';


abstract class Status {
  final DateTime timestamp;
  final List<String> viewedBy;

  Status({required this.timestamp, required this.viewedBy});

  Map<String, dynamic> toMap();

  static Status fromMap(Map<String, dynamic> data) {
    final type = data['type'];
    final timestamp = DateTime.parse(data['timestamp']);
    final viewedBy = List<String>.from(data['viewedBy'] ?? []);

    switch (type) {
      case 'text':
        return TextStatus(
          text: data['text'],
          timestamp: timestamp,
          viewedBy: viewedBy,
        );
      case 'image':
        return ImageStatus(
          imageUrl: data['url'],
          timestamp: timestamp,
          viewedBy: viewedBy,
        );
      case 'video':
        return VideoStatus(
          videoUrl: data['url'],
          timestamp: timestamp,
          viewedBy: viewedBy,
        );
      default:
        throw Exception("Unknown status type: $type");
    }
  }
}
