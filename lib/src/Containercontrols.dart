import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../src/utils.dart';
import 'package:screen/screen.dart';

// ignore: must_be_immutable
class FlutterProgressBar extends StatefulWidget {
  final VideoPlayerController controller;
  double progressvol;
  FlutterProgressBar({this.controller, this.progressvol});
  @override
  _FlutterProgressBarState createState() => _FlutterProgressBarState();
}

class _FlutterProgressBarState extends State<FlutterProgressBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(() {
      setState(() {});
    });
  }

  void seekToRelativePosition(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    final Offset tapPos = box.globalToLocal(globalPosition);
    final double relative = tapPos.dx / box.size.width;
    final Duration position = widget.controller.value.duration * relative;
    widget.controller.seekTo(position);
  }

  String formatDuration(Duration position) {
    final ms = position.inMilliseconds;
    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;
    final hoursString = hours >= 10 ? '$hours' : hours == 0 ? '00' : '0$hours';
    final minutesString =
        minutes >= 10 ? '$minutes' : minutes == 0 ? '00' : '0$minutes';
    final secondsString =
        seconds >= 10 ? '$seconds' : seconds == 0 ? '00' : '0$seconds';
    final formattedTime =
        '${hoursString == '00' ? '' : hoursString + ':'}$minutesString:$secondsString';
    return formattedTime;
  }

  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var orientation;
    bool _mediaOrientation() {
      orientation = MediaQuery.of(context).orientation;
      if (orientation == Orientation.landscape) {
        return true;
      } else {
        return false;
      }
    }

    return SafeArea(
      child: Container(
        color: Colors.black54,
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.045,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "${formatDuration(widget.controller.value.position)}",
                        style: TextStyle(color: Colors.white70, fontSize: 16.0),
                      ),
                      SizedBox(
                          width: _mediaOrientation()
                              ? MediaQuery.of(context).size.width * 0.02
                              : MediaQuery.of(context).size.width * 0.04),
                      Container(
                        height: MediaQuery.of(context).size.height / 16,
                        width: _mediaOrientation()
                            ? MediaQuery.of(context).size.width - 200
                            : MediaQuery.of(context).size.width - 150,
                        child: GestureDetector(
                          child: CustomPaint(
                            painter:
                                progressFiller(controller: widget.controller),
                          ),
                          onHorizontalDragStart: (DragStartDetails details) {
                            if (!widget.controller.value.initialized) {
                              return;
                            }

                            if (widget.controller.value.isPlaying) {
                              widget.controller.pause();
                            }
                          },
                          onHorizontalDragUpdate: (DragUpdateDetails details) {
                            seekToRelativePosition(details.globalPosition);
                          },
                          onHorizontalDragEnd: (DragEndDetails details) {
                            widget.controller.play();
                          },
                          onTapDown: (TapDownDetails details) {
                            if (!widget.controller.value.initialized) {
                              return;
                            }
                            seekToRelativePosition(details.globalPosition);
                          },
                        ),
                      ),
                      SizedBox(
                        width: _mediaOrientation()
                            ? MediaQuery.of(context).size.width * 0.02
                            : MediaQuery.of(context).size.width * 0.05,
                      ),
                      Text(
                        "${formatDuration(widget.controller.value.duration)}",
                        style: TextStyle(color: Colors.white70, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: _mediaOrientation()
                        ? MediaQuery.of(context).size.width * 0.2
                        : MediaQuery.of(context).size.width * 0.1,
                  ),
                  IconButton(
                    icon: Icon(
                      isMute ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white70,
                      size: 30,
                    ),
                    onPressed: () {
                      if (widget.controller.value.volume > 0.0) {
                        widget.controller.setVolume(0.0);
                        setState(() {
                          isMute = true;
                        });
                      } else {
                        widget.controller.setVolume(widget.progressvol);

                        setState(() {
                          isMute = false;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  IconButton(
                    icon: widget.controller.value.isPlaying
                        ? Icon(Icons.pause, color: Colors.white70, size: 38)
                        : Icon(Icons.play_arrow,
                            color: Colors.white70, size: 38),
                    onPressed: () {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.pause();
                        Screen.keepOn(true);
                      } else {
                        widget.controller.play();
                      }
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.aspect_ratio, color: Colors.white70),
                        iconSize: 30,
                        onPressed: () {
                          Provider.of<Aspect>(context, listen: false)
                              .addCnt(); //TO add Count to show the AspectRatio from the list
                        },
                      ),
                      Text(
                        "${Provider.of<Aspect>(context).tap_name}",
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class progressFiller extends CustomPainter {
  VideoPlayerController controller;
  progressFiller({this.controller});
  @override
  void paint(Canvas canvas, Size size) {
    final height = 5.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(
              0.0,
              size.height /
                  2), //TO control the position of slider in the container
          Offset(
              size.width,
              size.height / 2 +
                  height), //TO control the position of slider in the container
        ),
        Radius.circular(5.0), //To make end's of slider to be circular
      ),
      Paint()..color = Colors.white70,
    );
    final double partPlayed = controller.value.position.inMilliseconds /
        controller.value.duration.inMilliseconds;
    final double playful =
        partPlayed > 1 ? size.width : partPlayed * size.width;
    canvas.drawRRect(
      //To fill the part played in the slider
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2),
          Offset(playful, size.height / 2 + height),
        ),
        Radius.circular(5.0),
      ),
      Paint()..color = Colors.red,
    );

    canvas.drawCircle(
        Offset(playful, size.height / 2 + 2),
        10.0,
        Paint()
          ..color = Colors.red); //circular head attached at the end of slider
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
