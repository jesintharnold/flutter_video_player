library fluttervideoplayer;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:video_player_flutter/src/Containercontrols.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import './src/utils.dart';


// ignore: must_be_immutable
class Fluttervideoplayer extends StatefulWidget {
  VideoPlayerController controller;
  final double flutterVolume;
  bool enableLooping;
  bool enableScaling;
  bool allowonlylandscape=false;

  Fluttervideoplayer({@required this.controller,@required this.flutterVolume,@required this.enableLooping,@required this.enableScaling,this.allowonlylandscape}):assert(controller !=null);

  @override
  _FluttervideoplayerState createState() => _FluttervideoplayerState();
}

class _FluttervideoplayerState extends State<Fluttervideoplayer> {

  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;
  bool _hidebar=true;
  Future<void>initalizeVideoPlayerFuture;
  var orientation;

  @override
  void initState() {


    super.initState();
    widget.controller.setVolume(widget.flutterVolume);
    widget.controller.setLooping(widget.enableLooping);
    initalizeVideoPlayerFuture=widget.controller.initialize();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight

    ]);



  }
  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  bool _mediaorientation(){
    orientation=MediaQuery.of(context).orientation;
    if(orientation==Orientation.landscape){
      return true;
    }
    else{
      return false;
    }

  }

  // ignore: non_constant_identifier_names
  void Set_landscape(){

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight

    ]);
  }

  // ignore: non_constant_identifier_names
  void set_potrait(){


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown

    ]);
  }





  @override
  Widget build(BuildContext context) {






    return ChangeNotifierProvider(

      create:(ctx)=>Aspect(),
      child:Scaffold(
        resizeToAvoidBottomPadding:false,
        body: FutureBuilder(
            future:initalizeVideoPlayerFuture,
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.done){
                return Center(
                  child: Container(
                    height:MediaQuery.of(context).size.height,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.black,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: widget.enableScaling?GestureDetector(
                            onScaleStart:(ScaleStartDetails details){
                              _baseScaleFactor=_scaleFactor;
                            },
                            onScaleUpdate: (ScaleUpdateDetails setails){
                              _scaleFactor=_baseScaleFactor*setails.scale;
                              print(_scaleFactor);
                              setState(() {

                              });
                            },
                            child: Center(
                                child:Transform.scale(
                                  origin:Offset(0.0,0.0),
                                  scale:_scaleFactor,
                                  child: AspectRatio(
                                    aspectRatio:Provider.of<Aspect>(context).tap_count,
                                    child:VideoPlayer(widget.controller),
                                  ),
                                )
                            ),
                            // To Make a Tap on the screen to make it _hideStuff to be True
                            onTap:(){

                              setState(() {
                                _hidebar=!_hidebar;
                              });






                            },



                          ):GestureDetector(
                            child: Center(
                              child: AspectRatio(
                                aspectRatio:Provider.of<Aspect>(context).tap_count,
                                child:VideoPlayer(widget.controller),
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                _hidebar=!_hidebar;
                              });
                            },

                          ),),

                        Positioned(
                          top:50,
                          right:20,
                          child:AnimatedOpacity(
                            duration:Duration(milliseconds:500),
                            opacity:widget.allowonlylandscape?0.0:_hidebar?0.0:1.0,
                            child:IconButton(
                              icon:Icon(Icons.screen_rotation,color:Colors.white70,),
                              iconSize:30,
                              onPressed: (){
                                if(_mediaorientation()==true){
                                  // ignore: unnecessary_statements
                                  widget.allowonlylandscape?null:set_potrait();
                                }else{
                                  Set_landscape();
                                }




                              },
                            ),
                          ),
                        ),

                        Positioned(
                          bottom:0.1,
                          child: AnimatedOpacity(
                              duration:Duration(milliseconds:500),
                              opacity:_hidebar?0.0:1.0,
                              child: FlutterProgressBar(controller:widget.controller,progressvol:widget.flutterVolume,)
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }
              else{
                return Center(
                  child:CircularProgressIndicator(),
                );
              }
            }
        ),
      ),
    );
  }
}
