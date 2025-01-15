import 'package:whatsapp_clone/model/status/abstract.dart';



class VideoStatus extends Status {
  final String videoUrl;

  VideoStatus({
    required this.videoUrl,
    required DateTime timestamp,
    required List<String> viewedBy,
  }) : super(timestamp: timestamp, viewedBy: viewedBy);

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': 'video',
      'url': videoUrl,
      'timestamp': timestamp.toIso8601String(),
      'viewedBy': viewedBy,
    };
  }
}