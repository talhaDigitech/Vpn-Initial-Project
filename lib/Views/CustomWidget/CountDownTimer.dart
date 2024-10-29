import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Views/Constant.dart';

class CountDownTimer extends StatefulWidget {
  final bool startTimer;
  const CountDownTimer({super.key, required this.startTimer});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Duration _duration = Duration();
  Timer? _timer;

  startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds + 1);
      });
    });
  }

  stopTimer(){
    _timer?.cancel();
    _timer = null;
    _duration = Duration();
  } 
  @override
  Widget build(BuildContext context) {
    if(_timer == null || !widget.startTimer)
    widget.startTimer ? startTimer() : stopTimer();

    String twoDigit(int n) =>  n.toString().padLeft(2,"0");
    final _minutes = twoDigit(_duration.inMinutes.remainder(60));
    final _seconds = twoDigit(_duration.inSeconds.remainder(60));
    final _hours = twoDigit(_duration.inHours.remainder(60));
    return Text("$_hours:$_minutes:$_seconds",
    style: boldStyle,
    );
  }
}