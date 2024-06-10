import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:brahmayogi/Screens/Homepage.dart';
import 'package:bubble/bubble.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class Group extends StatefulWidget {
  final String profileImg, name, grpid;
  const Group({Key? key, this.profileImg = '', this.name = '', this.grpid = ''})
      : super(key: key);

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  ScrollController? _controller;
  @override
  void initState() {
    getmsg();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFDCE8EE),
      appBar: AppBar(
        backgroundColor: Color(0xFF947BF5),
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, size: 28),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.profileImg),
                radius: 20,
                backgroundColor: Colors.white,
              )
            ],
          ),
        ),
        title: Column(
          children: [
            Text(widget.name),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () {},
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const Home()),
      //     );
      //   },
      //   child: Icon(Icons.home, size: 35),
      //   backgroundColor: Color(0xFF947BF5),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GroupMsg(),
    );
  }


  Future<void> getmsg() async {
    var url = "http://bhramayogi.teckzy.co.in/User_api/group_msg";
    var pref = await SharedPreferences.getInstance();
    var grpid = pref.getString('group_id');
    var finalurl = Uri.parse(url);
    var res = await http.post(finalurl, headers: <String, String>{
      'X-API-KEY': 'yogi@123',
    }, body: {
      'group_id': widget.grpid,
    });

    var decodeValue = json.decode(res.body);

    setState(() {
      message_list = decodeValue['datas']['message_list'];



      print(message_list.toString());
    });
    duration.clear();
    position.clear();
    isPlaying.clear();
    isLoading.clear();
    isPause.clear();
    for (int i = 0; i < message_list.length; i++) {
      duration.add(Duration());
      position.add(Duration());
      isPlaying.add(false);
      isLoading.add(false);
      isPause.add(false);
    }
  }
}
var grlist = [];
var message_list = [];

bool playing = true;
IconData playbtn = Icons.play_arrow;

List<Duration> duration = [];
List<Duration> position = [];
List<bool> isPlaying = [];
List<bool> isLoading = [];
List<bool> isPause = [];

class GroupMsg extends StatefulWidget {
  GroupMsg({Key? key}) : super(key: key);

  @override
  State<GroupMsg> createState() => _GroupMsgs();
}

class _GroupMsgs extends State<GroupMsg> {
  static const styleSomebody = BubbleStyle(
    nip: BubbleNip.leftCenter,
    color: Colors.white,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );
  ScrollController? _controller;
  VideoPlayerController? controller;
  var _playingIndex = -1;
  var _disposed = false;
  var _isFullScreen = false;
  var _isEndOfClip = false;
  var _progress = 0.0;
  var _showingDialog = false;
  Timer? _timerVisibleControl;
  double _controlAlpha = 1.0;
  int playindex=0;



  @override
  void initState() {
    Wakelock.enable();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller?.animateTo(
        _controller!.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      );
      print(9786);

    });
    // TODO: implement initState
    super.initState();
  }

  void _onTapVideo() {
    debugPrint("_onTapVideo $_controlAlpha");
    setState(() {
      _controlAlpha = _controlAlpha > 0 ? 0 : 1;
    });
    _timerVisibleControl?.cancel();
    _timerVisibleControl = Timer(Duration(seconds: 2), () {
      if (_isPlaying) {
        setState(() {
          _controlAlpha = 0.0;
        });
      }
    });
  }
  var _playing = true;
  bool get _isPlaying {
    return _playing;
  }
  set _isPlaying(bool value) {
    _playing = value;
    _timerVisibleControl?.cancel();
    if (value) {
      _timerVisibleControl = Timer(Duration(seconds: 2), () {
        if (_disposed) return;
        setState(() {
          _controlAlpha = 0.0;
        });
      });
    } else {
      _timerVisibleControl = Timer(Duration(milliseconds: 200), () {
        if (_disposed) return;
        setState(() {
          _controlAlpha = 1.0;
        });
      });
    }
  }
  void _toggleFullscreen() async {
    if (_isFullScreen) {
      _exitFullScreen();
    } else {
      _enterFullScreen();
    }
  }

  void _enterFullScreen() async {
    debugPrint("enterFullScreen");
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    if (_disposed) return;
    setState(() {
      _isFullScreen = true;
    });
  }

  void _exitFullScreen() async {
    debugPrint("exitFullScreen");
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (_disposed) return;
    setState(() {
      _isFullScreen = false;
    });
  }

  void _initializeAndPlay(String message) async {
    print("_initializeAndPlay ---------> $message");



    final controller2 =
         VideoPlayerController.network(message);


    final old = controller2;
    controller = controller2;
    if (old != null) {
      old.removeListener(_onControllerUpdated);
      old.pause();
      debugPrint("---- old contoller paused.");
    }

    debugPrint("---- controller changed.");
    setState(() {});

    controller2
      ..initialize().then((_) {
        debugPrint("---- controller initialized");
        // old?.dispose();
        // _playingIndex = index;
        _duration = null;
        _position = null;
        controller2.addListener(_onControllerUpdated);
        controller2.play();
        setState(() {});
      });
  }


  var _updateProgressInterval = 0.0;
  Duration? _duration;
  Duration? _position;
  bool loadvedio=false;

  void _onControllerUpdated() async {
    if (_disposed) return;
    // blocking too many updation
    // important !!
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_updateProgressInterval > now) {
      return;
    }
    _updateProgressInterval = now + 500.0;

    final controller2 = controller;
    if (controller2 == null) return;
    if (!controller2.value.isInitialized) return;
    if (_duration == null) {
      _duration = controller!.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;

    var position = await controller2.position;
    _position = position;
    final playing = controller2.value.isPlaying;
    final isEndOfClip = position!.inMilliseconds > 0 && position.inSeconds + 1 >= duration.inSeconds;
    if (playing) {
      // handle progress indicator
      if (_disposed) return;
      setState(() {
        _progress = position.inMilliseconds.ceilToDouble() / duration.inMilliseconds.ceilToDouble();
      });
    }

    // handle clip end
    // if (_isPlaying != playing || _isEndOfClip != isEndOfClip) {
    //   _isPlaying = playing;
    //   _isEndOfClip = isEndOfClip;
    //   debugPrint("updated -----> isPlaying=$playing / isEndOfClip=$isEndOfClip");
    //   if (isEndOfClip && !playing) {
    //     debugPrint("========================== End of Clip / Handle NEXT ========================== ");
    //     final isComplete = _playingIndex == _clips.length - 1;
    //     if (isComplete) {
    //       print("played all!!");
    //       if (!_showingDialog) {
    //         _showingDialog = true;
    //         _showPlayedAllDialog().then((value) {
    //           _exitFullScreen();
    //           _showingDialog = false;
    //         });
    //       }
    //     } else {
    //       _initializeAndPlay(_playingIndex + 1);
    //     }
    //   }
    // }
  }
  Widget _playView(BuildContext context,int plaui) {
    final controller2 = controller;
    if (controller2 != null && controller2.value.isInitialized&&playindex==plaui) {
      return AspectRatio(
        //aspectRatio: controller.value.aspectRatio,
        aspectRatio: 16.0 / 9.0,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: VideoPlayer(controller2),
              onTap: _onTapVideo,
            ),
            _controlAlpha > 0
                ? AnimatedOpacity(
              opacity: _controlAlpha,
              duration: Duration(milliseconds: 250),
              child: _controlView(context),
            )
                : Container(),
          ],
        ),
      );
    } else {
      return loadvedio?AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Center(
            child: Text('Loading....',style: TextStyle(color: Colors.white),)),
      ):AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Center(
            child: Icon(Icons.play_arrow_rounded,color: Colors.white,)),
      );
    }
  }
  Widget _controlView(BuildContext context) {
    return Column(
      children: <Widget>[
        _topUI(),
        Expanded(
          child: _centerUI(),
        ),
        _bottomUI()
      ],
    );
  }
  Widget _centerUI() {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TextButton(
            //   onPressed: () async {
            //     final index = _playingIndex - 1;
            //     // if (index > 0 && _clips.length > 0) {
            //     //   _initializeAndPlay(index);
            //     // }
            //   },
            //   child: Icon(
            //     Icons.fast_rewind,
            //     size: 36.0,
            //     color: Colors.white,
            //   ),
            // ),
            TextButton(
              onPressed: () async {
                if (_isPlaying) {
                  controller?.pause();
                  _isPlaying = false;
                } else {
                  controller?.play();
                  _isPlaying = true;


                  // final controller2 = controller;
                  // if (controller2 != null) {
                  //   final pos = _position?.inSeconds ?? 0;
                  //   final dur = _duration?.inSeconds ?? 0;
                  //   final isEnd = pos == dur;
                  //   if (isEnd) {
                  //     _initializeAndPlay('');
                  //   } else {
                  //     controller2.play();
                  //   }
                  // }
                }
                setState(() {});
              },
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 56.0,
                color: Colors.white,
              ),
            ),

          ],
        ));
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _topUI() {
    final noMute = (controller?.value?.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final min = convertTwo(remained ~/ 60.0);
    final sec = convertTwo(remained % 60);
    return Row(
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(offset: const Offset(0.0, 0.0), blurRadius: 4.0, color: Color.fromARGB(50, 0, 0, 0)),
                ]),
                child: Icon(
                  noMute ? Icons.volume_up : Icons.volume_off,
                  color: Colors.white,
                )),
          ),
          onTap: () {
            if (noMute) {
              controller?.setVolume(0);
            } else {
              controller?.setVolume(1.0);
            }
            setState(() {});
          },
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          "$min:$sec",
          style: TextStyle(
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 1.0),
                blurRadius: 4.0,
                color: Color.fromARGB(150, 0, 0, 0),
              ),
            ],
          ),
        ),
        SizedBox(width: 10)
      ],
    );
  }

  Widget _bottomUI() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20),
        Expanded(
          child: Slider(
            value: max(0, min(_progress * 100, 100)),
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                _progress = value * 0.01;
              });
            },
            onChangeStart: (value) {
              debugPrint("-- onChangeStart $value");
              controller?.pause();
            },
            onChangeEnd: (value) {
              debugPrint("-- onChangeEnd $value");
              final duration = controller?.value?.duration;
              if (duration != null) {
                var newValue = max(0, min(value, 99)) * 0.01;
                var millis = (duration.inMilliseconds * newValue).toInt();
                controller?.seekTo(Duration(milliseconds: millis));
                controller?.play();
              }
            },
          ),
        ),
        // IconButton(
        //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //   color: Colors.yellow,
        //   icon: Icon(
        //     Icons.fullscreen,
        //     color: Colors.white,
        //   ),
        //   onPressed: _toggleFullscreen,
        // ),
      ],
    );
  }


  @override
  void dispose() {
    _disposed = true;
    _timerVisibleControl?.cancel();
    Wakelock.disable();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // _exitFullScreen();
    controller?.pause(); // mute instantly
    controller?.dispose();
    controller = null;
    super.dispose();
  }

  static const styleMe = BubbleStyle(
    nip: BubbleNip.rightCenter,
    color: Color.fromARGB(255, 225, 255, 199),
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,
  );

  // Widget slider() {
  //   return Container(
  //     child: Slider.adaptive(
  //         value: position.inSeconds.toDouble(),
  //         activeColor: Color(0xFF947BF5),
  //         inactiveColor: Colors.grey,
  //         max: musiclength.inSeconds.toDouble(),
  //         onChanged: (Value) {
  //           seekToSec(Value.toInt());
  //         }),
  //   );
  // }

  void seekToSec(int sec) {
    Duration newpos = Duration(seconds: sec);
  }

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  _playAudio(audio, index) async {
    if (audio != null && isPause.length > 0) {
      final play = audio;

      if (isPause[index]) {
        await advancedPlayer.resume();
        setState(() {
          isPlaying[index] = true;
          isPause[index] = false;
        });
      } else if (isPlaying[index]) {
        await advancedPlayer.pause();
        setState(() {
          for (int i = 0; i < isPlaying.length; i++) {
            isPlaying[i] = false;
          }

          isPause[index] = true;
        });
      } else {
        for (int i = 0; i < isPlaying.length; i++) {
          isPlaying[i] = false;
        }
        setState(() {
          isLoading[index] = true;
        });
        await advancedPlayer.stop();
        await advancedPlayer.setSourceUrl(play);
      
        await advancedPlayer.resume();
        setState(() {
          isPlaying[index] = true;
        });
      }

      advancedPlayer.onDurationChanged.listen((Duration d) {
        setState(() {
          for (int i = 0; i < isPlaying.length; i++) {
            duration[i] = new Duration();
          }
          duration[index] = d;
          isLoading[index] = false;
        });
      });
      advancedPlayer.onPositionChanged.listen((Duration p) {
        setState(() {
          for (int i = 0; i < isPlaying.length; i++) {
            position[i] = new Duration();
          }
          position[index] = p;
        });
      });

      advancedPlayer.onPlayerComplete.listen((event) {
        setState(() {
          isPlaying[index] = false;
          duration[index] = new Duration();
          position[index] = new Duration();
        });
      });
    }
  }


  static var httpClient = new HttpClient();
  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getTemporaryDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Color(0xFFDCE8EE),
        child: ListView.builder(
            reverse: true,
          // physics: ClampingScrollPhysics(),
          // controller:  _controller,
            itemCount: message_list.length,
            itemBuilder: (BuildContext, index) {
              return Column(
                children: [
                  message_list[index]['type'] == 'text'
                      ? Bubble(
                          style: styleSomebody,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children:[
                              SelectableText(
                                message_list[index]['message']!,
                                style:
                                TextStyle(fontFamily: 'palatino', fontSize: 12),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SelectableText(
                                    DateFormat.yMd().add_jms().format(DateTime.parse('${message_list[index]['date_time']!}')),
                                    style:
                                    TextStyle(fontFamily: 'palatino', fontSize: 10),
                                  ),
                                ],
                              )
                            ]
                          ),
                        )
                      : Container(),
                  message_list[index]['type'] == 'image'
                      ? Bubble(
                          style: styleSomebody,
                          child: Container(

                            child: Column(
                              children: [
                                InkWell(
                                  onTap: (() {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                imageProvider: NetworkImage(
                                                    message_list[index]['message']!),
                                              ));
                                        });
                                  }),
                                  child: Image.network(
                                    message_list[index]['message']!,
                                    fit: BoxFit.cover,
                                    height: 180,
                                    width: 160,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SelectableText(
                                      DateFormat.yMd().add_jms().format(DateTime.parse('${message_list[index]['date_time']!}')),
                                      style:
                                      TextStyle(fontFamily: 'palatino', fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : message_list[index]['type'] == 'audio' &&
                              duration[index] != null
                          ? Column(
                    children: [
                      BubbleNormalAudio(

                        color: Colors.white70,
                        duration: duration[index].inSeconds.toDouble(),
                        position: position[index].inSeconds.toDouble(),
                        isPlaying: isPlaying[index],
                        isLoading: isLoading[index],
                        isPause: isPause[index],
                        onSeekChanged: (value1) async {
                          await advancedPlayer
                              .seek(Duration(seconds: value1.round()));
                        },
                        onPlayPauseButtonClick: () => _playAudio(
                            message_list[index]['message']!, index),
                        sent: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SelectableText(
                            DateFormat.yMd().add_jms().format(DateTime.parse('${message_list[index]['date_time']!}')),
                            style:
                            TextStyle(fontFamily: 'palatino', fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  )
                          : message_list[index]['type'] == 'files'
                              ? Bubble(
                                  style: styleSomebody,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          File download = await _downloadFile(
                                              message_list[index]['message']
                                                  .toString(),
                                              message_list[index]['message']
                                                  .toString()
                                                  .split('/')
                                                  .last);
                                          print(download);
                                          OpenFilex.open(download.path);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.attach_file_outlined),
                                            Container(
                                              width: 180,
                                              child: Text(message_list[index]['message']
                                                  .toString()
                                                  .split('/')
                                                  .last),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SelectableText(
                                            DateFormat.yMd().add_jms().format(DateTime.parse('${message_list[index]['date_time']!}')),
                                            style:
                                            TextStyle(fontFamily: 'palatino', fontSize: 10),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : message_list[index]['type'] == 'link'?
                  Bubble(
                    style: styleSomebody,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            Uri? url;
                            launch(message_list[index]['message']);




                            // await launch(message_list[index]['message']);


                          },
                          child: Row(
                            children: [
                              Icon(Icons.open_in_browser),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 200,
                                  child: SelectableText.rich(TextSpan(
                                      text: message_list[index]['message'].toString(),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = ()async{
                                          launch(message_list[index]['message']);



                                        }

                                  ),style: TextStyle(color: Colors.blue),)
                              )
                            ],
                          ),
                        ),Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SelectableText(
                              DateFormat.yMd().add_jms().format(DateTime.parse('${message_list[index]['date_time']!}')),
                              style:
                              TextStyle(fontFamily: 'palatino', fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    ),
                  ):message_list[index]['type'] == 'video'?
                  Bubble(
                    style: styleSomebody,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (() {
                            _initializeAndPlay('http://bhramayogi.teckzy.co.in/'+message_list[index]['message']);
                            playindex=index;

                          }),
                          child: Container(
                            child: Center(child: _playView(context,index),),
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SelectableText(
                              DateFormat.yMd().add_jms().format(DateTime.parse('${message_list[index]['date_time']!}')),
                              style:
                              TextStyle(fontFamily: 'palatino', fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    ),
                  ):Container(),
                  SizedBox(height: 12),
                ],
              );
            }),
      ),
    );
  }
}
