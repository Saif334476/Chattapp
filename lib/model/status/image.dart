import 'package:whatsapp_clone/model/status/abstract.dart';

class ImageStatus extends Status {
  final String imageUrl;

  ImageStatus({
    required this.imageUrl,
    required DateTime timestamp,
    required List<String> viewedBy,
  }) : super(timestamp: timestamp, viewedBy: viewedBy);

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': 'image',
      'url': imageUrl,
      'timestamp': timestamp.toIso8601String(),
      'viewedBy': viewedBy,
    };
  }
}