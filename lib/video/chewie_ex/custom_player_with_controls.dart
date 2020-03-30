import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/video/chewie2/src/chewie_player.dart';
import 'package:video_player/video_player.dart';

class CustomPlayerWithControls extends StatelessWidget {
  final double width;
  final double height;

  ///入参增加容器宽和高
  CustomPlayerWithControls({
    Key key,
    this.width = 300,
    this.height = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChewieController chewieController = ChewieController.of(context);

    return _buildPlayerWithControls(chewieController, context);
  }

  Container _buildPlayerWithControls(
      ChewieController chewieController, BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          chewieController.placeholder ?? Container(),
          VideoPlayerContainer(width, height),
          chewieController.overlay ?? Container(),
          _buildControls(context, chewieController),
        ],
      ),
    );
  }

  Widget _buildControls(
    BuildContext context,
    ChewieController chewieController,
  ) {
    return chewieController.showControls &&
            chewieController.customControls != null
        ? chewieController.customControls
        : Container();
  }
}

///与源码中的PlayerWithControls相比，VideoPlayerContainer继承了StatefulWidget.
///监听videoPlayerController的变化，拿到视频宽高比。
class VideoPlayerContainer extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;

  ///根据入参的宽高，计算得到容器宽高比
  double _viewRatio;

  VideoPlayerContainer(
    this.maxWidth,
    this.maxHeight, {
    Key key,
  })  : _viewRatio = maxWidth / maxHeight,
        super(key: key);

  @override
  _VideoPlayerContainerState createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {
  double _aspectRatio;

  ChewieController chewieController;

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    chewieController.videoPlayerController.removeListener(_updateState);
  }

  @override
  void didChangeDependencies() {
    final _oldController = chewieController;
    chewieController = ChewieController.of(context);
    if (_oldController != chewieController) {
      _dispose();
      chewieController.videoPlayerController.addListener(_updateState);
      _updateState();
    }
    super.didChangeDependencies();
  }

  void _updateState() {
    VideoPlayerValue value = chewieController?.videoPlayerController?.value;
    if (value != null) {
      double newAspectRatio = value.size != null ? value.aspectRatio : null;
      if (newAspectRatio != null && newAspectRatio != _aspectRatio) {
        setState(() {
          _aspectRatio = newAspectRatio;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_aspectRatio == null) {
      return Container();
    }
    double width;
    double height;

    ///两个宽高比进行比较，保证VideoPlayer不超出容器，且不会产生变形
    if (_aspectRatio > widget._viewRatio) {
      width = widget.maxWidth;
      height = width / _aspectRatio;
    } else {
      height = widget.maxHeight;
      width = height * _aspectRatio;
    }

    return Center(
      child: Container(
        width: width,
        height: height,
        child: VideoPlayer(chewieController.videoPlayerController),
      ),
    );
  }
}
