import 'package:whatsapp_clone/model/status/abstract.dart';

class TextStatus extends Status {
  final String text;

  TextStatus({
    required this.text,
    required DateTime timestamp,
    required List<String> viewedBy,
  }) : super(timestamp: timestamp, viewedBy: viewedBy);

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': 'text',
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'viewedBy': viewedBy,
    };
  }
}