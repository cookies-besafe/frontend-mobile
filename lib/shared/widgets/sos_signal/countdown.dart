import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

import 'styles.dart';

class SosCountdown extends StatefulWidget {
  final VoidCallback onEnd;

  const SosCountdown({required this.onEnd, Key? key}) : super(key: key);

  @override
  State<SosCountdown> createState() => _SosCountdownState();
}

class _SosCountdownState extends State<SosCountdown> {
  final int _start = 10;
  int _current = 10;
  late StreamSubscription<CountdownTimer> sub;

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: _start),
      const Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      widget.onEnd();
      sub.cancel();
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _current.toString(),
      style: sosActiveTextStyle,
    );
  }
}
