import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PreviewStatusByCam extends StatefulWidget {
  final String? captured;

  PreviewStatusByCam({Key? key, this.captured}) : super(key: key);

  @override
  _PreviewStatusByCamState createState() => _PreviewStatusByCamState();
}

class _PreviewStatusByCamState extends State<PreviewStatusByCam> {
  VideoPlayerController? _videoController;
  bool isVideo = false;

  @override
  void initState() {
    super.initState();
    if (widget.captured != null) {
      final file = File(widget.captured!);
      final fileType = file.path.split('.').last.toLowerCase();
      isVideo = fileType == 'mp4' || fileType == 'mov' || fileType == 'avi';

      if (isVideo) {
        _videoController = VideoPlayerController.file(file)
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          });
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.captured == null
          ? Center(
              child: Text("No media captured.",
                  style: TextStyle(color: Colors.white)))
          : Center(
              child: isVideo
                  ? _videoController != null && _videoController!.value.isInitialized
                      ? Stack(
                alignment: Alignment.topLeft,
                          children: [
                            AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            ),
                            Positioned(
                              top: 50,
                              left: 10,
                              child: Material(
                                color: Colors.transparent, // Prevents background issues
                                child: FloatingActionButton(
                                  heroTag: "unique_tag_for_close_button",
                                  backgroundColor: Color(0xff1A2941),
                                  onPressed: () => Navigator.pop(context),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),

                              ),
                            ),

                          ],
                        )
                      : CircularProgressIndicator()
                  : Image.file(File(widget.captured!), fit: BoxFit.contain),
            ),
    );
  }
}
