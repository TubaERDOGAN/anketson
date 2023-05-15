import 'package:flutter/material.dart';
import 'dart:async';

class Countdown extends StatefulWidget {
  final DateTime endTime;

  Countdown({required this.endTime});

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.endTime.difference(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft = widget.endTime.difference(DateTime.now());
      });
    });
  }

  String get days => _timeLeft.inDays.toString().padLeft(2, '0');

  String get hours => (_timeLeft.inHours % 24).toString().padLeft(2, '0');

  String get minutes => (_timeLeft.inMinutes % 60).toString().padLeft(2, '0');

  String get seconds => (_timeLeft.inSeconds % 60).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Text(
      '$days:$hours:$minutes:$seconds',
      style: TextStyle(fontSize: 30),
    );
  }
}