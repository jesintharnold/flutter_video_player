import 'package:video_player_flutter/video_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(VideoApp());
}


class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Fluttervideoplayer(controller:_controller,enableLooping:true,enableScaling:true,flutterVolume:0.5,allowonlylandscape:false,),

    );
  }


}