import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:xylophone/recorder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(XylophoneApp());
}

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      
        themeMode: ThemeMode.dark,
        home: Scaffold(
          
          appBar: AppBar(
            actions: [],
          ),
          body: Xylophone(),
          floatingActionButton: Recorder(),
        ));
  }
}

class Xylophone extends StatefulWidget {
  @override
  _XylophoneState createState() => _XylophoneState();
}

class _XylophoneState extends State<Xylophone> {
  final player = AudioCache();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight;

    return Container(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: height / 7,
              child: FlatButton(
                onPressed: () {
                  player.play('note1.wav');
                },
                color: Colors.red,
                child: Text(""),
              ),
            ),
            Container(
              height: height / 7,
              child: FlatButton(
                onPressed: () {
                  player.play('note2.wav');
                },
                color: Colors.orange,
                child: Text(""),
              ),
            ),
            Container(
              height: height / 7,
              child: FlatButton(
                onPressed: () {
                  player.play('note3.wav');
                },
                color: Colors.yellow,
                child: Text(""),
              ),
            ),
            Container(
              height: height / 7,
              child: FlatButton(
                onPressed: () {
                  player.play('note4.wav');
                },
                color: Colors.green,
                child: Text(""),
              ),
            ),
            Container(
              height: height / 7,
              child: FlatButton(
                onPressed: () {
                  player.play('note5.wav');
                },
                color: Colors.lightGreen,
                child: Text(""),
              ),
            ),
            Container(
              height: height / 7,
              child: FlatButton(
                onPressed: () {
                  player.play('note6.wav');
                },
                color: Colors.blue,
                child: Text(""),
              ),
            ),
            Container(
              height: height / 7,
              child: FlatButton(
                onPressed: () {
                  player.play('note7.wav');
                },
                color: Colors.purple[300],
                child: Text(""),
              ),
            ),
          ],
        ));
  }
}
