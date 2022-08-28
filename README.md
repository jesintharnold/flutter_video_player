[![Demo](https://img.shields.io/badge/PACKAGE-Video__player__flutter-blue)](https://pub.dev/packages/video_player_flutter)

[![status: archive](https://github.com/GIScience/badges/raw/master/status/archive.svg)](https://github.com/GIScience/badges#archive)

# Flutter Video Player Package
### 
 A Flutter based Video Player Package inspired from Mx-Player.
flutter_video_player based on Dart build using existing Video_Player and Wrapping with High-Level PlayBack access such as Zooming, Aspect Control,Preferred-Rotation and much more.
``Note:`` Tested only on Android 
###
Developer are Welcomed for Fork/Pull Request.Newer Features are Welcomed !!





# Demo
![Demo](https://github.com/jesintharnold/flutter_video_player/raw/master/assets/flutter_video_player.gif)

# Features
*  Video Zooming / Scaling  
*  Video Controller Hide/show with One-tap control
*  Custom option for potrait and Fullscreen Control
*  Custom option for Mute/volume control
*  Custom option for Restricting the Orientation
# Installation
First,Add the following as dependancy in ``pubspec.yaml``
```dart
dependencies:
  video_player_flutter: <latest_version>
  video_player: <latest_version>
  ```
  # Android
  Ensure that the following Permissions are enabled in your Android Manifest File ```<project root>/android/app/src/main/AndroidManifest.xml```
  ```xml
 <uses-permission android:name="android.permission.INTERNET"/>
  ```
  
   If You Want to Enable Zooming above the Notch Cut-out in SmartPhones.
   Navigate to ```<project root>/android/app/src/main/res``` and Create the new-Folder with the name ```values v-28``` And create a new ```styles.xml``` and paste the following snippet.
   
   ```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
<item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>
    </style>
</resources>
```

# IOS Warning 
The Package is not tested on Ios Devices.

# Example
```dart

import 'package:flutter_video_player/video_player_flutter.dart';
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
    _controller = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");//Specify the url/filePath/asset Path .
                                                                                                                             //No Need to initalize or Dispose VideoController.

}

@override
  void dispose() {
    super.dispose();
    
  }
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: fluttervideoplayer(controller:_controller,enableLooping:true,enableScaling:true,flutterVolume:0.5,allowonlylandscape:false,),
);
 }
}
```
