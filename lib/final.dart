import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';


  class Final {
final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    onChange: (value) => print('onChange $value'),
    onChangeSecond: (value) => print('onChangeSecond $value'),
    onChangeMinute: (value) => print('onChangeMinute $value'),
  );
  }
