import 'package:flutter/material.dart';
import 'package:flutter_sample/video/chewie_video_widget.dart';
import 'package:flutter_sample/video/chewie_video_widget2.dart';

void main() => runApp(MaterialApp(home: VideoPage()));

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  String videoUrl =
      "https://nico-android-apk.oss-cn-beijing.aliyuncs.com/landscape.mp4";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow[100],
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
            ),
            ChewieVideoWidget1(videoUrl),
            Container(
              height: 15,
            ),
            ChewieVideoWidget2(videoUrl),
          ],
        ),
      ),
    );
  }
}
