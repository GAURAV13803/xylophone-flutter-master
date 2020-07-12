
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          body: Xylophone(),
          
          //      floatingActionButton: Recorder(),
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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;
    // -Scaffold.of(context).appBarMaxHeight;

    return Container(
      height: height,
      child: Stack(
        overflow: Overflow.clip,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: height / 7,
                child: FlatButton(
                  onPressed: () {
                    player.play('note1.wav');
                  },
                  color: Colors.red,
                  child: Text(""),
                ),
              ),
              Container(
                width: height / 7,
                child: FlatButton(
                  onPressed: () {
                    player.play('note2.wav');
                  },
                  color: Colors.orange,
                  child: Text(""),
                ),
              ),
              Container(
                width: height / 7,
                child: FlatButton(
                  onPressed: () {
                    player.play('note3.wav');
                  },
                  color: Colors.yellow,
                  child: Text(""),
                ),
              ),
              Container(
                width: height / 7,
                child: FlatButton(
                  onPressed: () {
                    player.play('note4.wav');
                  },
                  color: Colors.green,
                  child: Text(""),
                ),
              ),
              Container(
                width: height / 7,
                child: FlatButton(
                  onPressed: () {
                    player.play('note5.wav');
                  },
                  color: Colors.lightGreen,
                  child: Text(""),
                ),
              ),
              Container(
                width: height / 7,
                child: FlatButton(
                  onPressed: () {
                    player.play('note6.wav');
                  },
                  color: Colors.blue,
                  child: Text(""),
                ),
              ),
              Container(
                width: height / 7,
                child: FlatButton(
                  onPressed: () {
                    player.play('note7.wav');
                  },
                  color: Colors.purple[300],
                  child: Text(""),
                ),
              ),
            ],
          ),
          Recorder(),
        ],
      ),
    );
    //
  }
}
