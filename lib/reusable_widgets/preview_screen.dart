import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import 'dart:typed_data';

class PreviewScreen extends StatefulWidget {
  final List<AssetEntity> mediaItems;

  const PreviewScreen({Key? key, required this.mediaItems}) : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentMedia = widget.mediaItems[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Preview'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              // Handle the 'done' action here (e.g., upload or save media).
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Uint8List?>(
              future: currentMedia.type == AssetType.video
                  ? currentMedia.thumbnailDataWithSize(ThumbnailSize(300, 300))
                  : currentMedia.thumbnailData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (currentMedia.type == AssetType.image) {
                  // Display image
                  return Image.memory(snapshot.data!, fit: BoxFit.contain);
                } else if (currentMedia.type == AssetType.video) {

                  return VideoPreview(asset: currentMedia);
                }

                return Center(child: Text("Unable to preview media."));
              },
            ),
          ),
          // Carousel to show all selected/captured items
          Container(
            height: 100,
            color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.mediaItems.length,
              itemBuilder: (context, index) {
                final mediaItem = widget.mediaItems[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  child: FutureBuilder<Uint8List?>(
                    future: mediaItem.thumbnailDataWithSize(
                      ThumbnailSize(100, 100),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: currentIndex == index
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        );
                      }
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.shade300,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPreview extends StatefulWidget {
  final AssetEntity asset;

  const VideoPreview({Key? key, required this.asset}) : super(key: key);

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    widget.asset.file.then((file) {
      if (file != null) {
        _controller = VideoPlayerController.file(file)
          ..initialize().then((_) {
            setState(() {}); // Ensure the UI updates when the video is ready.
            _controller.play();
          });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(child: CircularProgressIndicator());
  }
}
