import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Recorder extends StatefulWidget {
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder>
    with SingleTickerProviderStateMixin {
  //Fab Variables

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
//Fab Variable

//recorder variable
  FlutterAudioRecorder _recorder;
  Recording _recording;
  Timer _t;
  String _alert;
//recorder variable

//classes for FAB
  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
    Future.microtask(() {
      _prepare();
    });
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget record() {
    return Container(
        child: FloatingActionButton(
      onPressed: () {
        _startRecording();
      },
      tooltip: 'record',
      child: Icon(
        Icons.mic,
      ),
    ));
  }

  Widget pause() {
    return Container(
      child: FloatingActionButton(
        onPressed: () async {
          switch (_recording.status) {
            case RecordingStatus.Recording:
              {
                await _recorder.pause();
                setState(() {
                  isPaused = !isPaused;
                });
                break;
              }
            default:
              break;
          }
        },
        tooltip: 'pause',
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  Widget resumes() {
    return Container(
      child: FloatingActionButton(
        onPressed: () async {
          switch (_recording.status) {
            case RecordingStatus.Recording:
              {
                await _recorder.resume();
                setState(() {
                  isPaused = !isPaused;
                });
                break;
              }
            default:
              break;
          }
        },
        tooltip: "resume",
        child: Icon(Icons.pause),
      ),
    );
  }

  Widget stop() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          _stopRecording();
        },
        tooltip: 'stop',
        child: Icon(
          MdiIcons.stop,
          color: Colors.red,
        ),
      ),
    );
  }

  // Widget inbox() {
  //   return Container(
  //     child: FloatingActionButton.extended(
  //       onPressed: null,
  //       label: Text(
  //         '${_recording?.status ?? "-"}',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

//classes for FAB

//Classes for recorder

  // void _opt() async {
  // switch (_recording.status) {
  //     case RecordingStatus.Initialized:
  //       {
  //         await _startRecording();
  //         break;
  //       }
  //     case RecordingStatus.Recording:
  //       {
  //         await _stopRecording();
  //         break;
  //       }
  //     case RecordingStatus.Stopped:
  //       {
  //         await _prepare();
  //         break;
  //       }

  //     default:
  //       break;
  //   }
  // }

  // 刷新按钮

  Future _init() async {
    String customPath = '/xylophone';
    io.Directory appDocDirectory;
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = await getExternalStorageDirectory();
    }

    // can add extension like ".mp4" ".wav" ".m4a" ".aac"
    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString();

    // .wav <---> AudioFormat.WAV
    // .mp4 .m4a .aac <---> AudioFormat.AAC
    // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.

    _recorder = FlutterAudioRecorder(customPath,
        audioFormat: AudioFormat.WAV, sampleRate: 22050);
    await _recorder.initialized;
  }

  Future _prepare() async {
    var hasPermission = await FlutterAudioRecorder.hasPermissions;
    if (hasPermission) {
      await _init();
      var result = await _recorder.current();
      setState(() {
        _recording = result;
        _alert = "";
      });
    } else {
      setState(() {
        _alert = "Permission Required.";
      });
    }
  }

  bool isRecording = true;

  Future _startRecording() async {
    await _recorder.start();
    var current = await _recorder.current();
    setState(() {
      _recording = current;
      isRecording = false;
      isPaused = false;
    });
  }

  Future _stopRecording() async {
    var result = await _recorder.stop();
    final snackbar = SnackBar(
      content: Text('${_recording?.path ?? "-"}'),
      action: SnackBarAction(label: "view", onPressed: null),
    );
    setState(() {
      _recording = result;
      isRecording = true;
      isPaused = true;
    });

    switch (_recording.status) {
      case RecordingStatus.Paused:
        {
          await _prepare();
          break;
        }
      case RecordingStatus.Recording:
        {
          await _prepare();
          break;
        }
      case RecordingStatus.Stopped:
        {
          await _prepare();
          break;
        }
      default:
        break;
    }
    final data = Scaffold.of(context).showSnackBar(snackbar);
    return data;
  }

  // void _play() {
  //   AudioPlayer player = AudioPlayer();
  //   player.play(_recording.path, isLocal: true);
  // }

//Classes for recorder
  bool isPaused = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Transform(
        //   transform: Matrix4.translationValues(
        //     0.0,
        //     _translateButton.value * 3.0,
        //     0.0,
        //   ),
        //   child: record(),
        // ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: isRecording ? record() : stop(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: isPaused ? pause() : resumes(),
        ),
        toggle(),
      ],
    );
  }
}
