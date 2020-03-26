

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NicoVideoWidget extends StatefulWidget {

 final String playUrl;

  NicoVideoWidget(this.playUrl);
  @override
  _NicoVideoWidgetState createState() => _NicoVideoWidgetState();
}

class _NicoVideoWidgetState extends State<NicoVideoWidget> {

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;




  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.playUrl)..initialize();
//        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
