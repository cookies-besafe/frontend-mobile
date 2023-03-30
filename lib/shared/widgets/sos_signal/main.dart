import 'dart:async';
import 'dart:io';

import 'package:besafe/api_service.dart';
import 'package:besafe/shared/styles.dart';
import 'package:besafe/shared/utils.dart';
import 'package:besafe/shared/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import '../modals/yes_no_dialog.dart';
import 'styles.dart';
import 'package:flutter/material.dart';

import 'countdown.dart';

enum Status { idle, launching, active }

class _SosSignalHeading extends StatelessWidget {
  final Status status;

  const _SosSignalHeading({required this.status, Key? key}) : super(key: key);

  String _getText() {
    switch (status) {
      case Status.idle:
        return 'Press a button';
      case Status.launching:
        return 'Starting...';
      case Status.active:
        return 'Recording...';
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          _getText(),
          textAlign: TextAlign.center,
          style: sosButtonHeadingStyle,
        ),
      );
}

class _SosHelpTextOrCancelBtn extends StatelessWidget {
  final Status status;
  final VoidCallback onPressed;

  _SosHelpTextOrCancelBtn(
      {required this.status, required this.onPressed, Key? key})
      : super(key: key);

  final Widget sosSignalHelpText = Container(
    padding: const EdgeInsets.all(8),
    child: const Text(
      'Current button will record video, audio and send “SOS” message to trusted people',
      textAlign: TextAlign.center,
      style: sosHelpTextStyle,
    ),
  );

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.idle:
        return sosSignalHelpText;
      case Status.launching:
        return SizedBox(
            width: 200,
            height: 36,
            child:
                SecondaryOutlinedButton(text: 'Cancel', onPressed: onPressed));
      case Status.active:
        return Container();
    }
  }
}

class SosButton extends StatelessWidget {
  final Status status;
  final VoidCallback preLaunchSignal, activateSignal, promptStopActivatedSignal;

  const SosButton(
      {Key? key,
      required this.status,
      required this.preLaunchSignal,
      required this.promptStopActivatedSignal,
      required this.activateSignal})
      : super(key: key);

  Widget _getSosButton(
          ButtonStyle buttonStyle, VoidCallback? onPressed, Widget widget) =>
      Container(
        width: 200,
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 16),
        child:
            TextButton(onPressed: onPressed, style: buttonStyle, child: widget),
      );

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.idle:
        return _getSosButton(
            sosButtonIdleStyle,
            preLaunchSignal,
            const Text(
              'SOS',
              style: sosIdleTextStyle,
            ));
      case Status.launching:
        return _getSosButton(
            sosButtonActiveStyle, null, SosCountdown(onEnd: activateSignal));
      case Status.active:
        return _getSosButton(sosButtonActiveStyle, promptStopActivatedSignal,
            const Icon(Icons.stop_rounded, size: 160, color: primaryColor));
    }
  }
}

class SosSignal extends StatefulWidget {
  const SosSignal({Key? key}) : super(key: key);

  @override
  State<SosSignal> createState() => _SosSignalState();
}

class _SosSignalState extends State<SosSignal> {
  Status status = Status.idle;
  final audioRecorder = FlutterSoundRecorder();
  bool isAudioRecorderReady = false;
  SosRequestApi? sosRequest;
  int? requestId;

  @override
  void initState() {
    super.initState();

    initRecorder();
    initGeolocation().then((locationStream) =>
        {sosRequest = SosRequestApi(locationStream: locationStream)});
  }

  @override
  void dispose() {
    audioRecorder.closeRecorder();
    sosRequest?.stop();

    super.dispose();
  }

  Future initRecorder() async {
    PermissionStatus status;

    do {
      status = await Permission.microphone.request();
    } while (status != PermissionStatus.granted);

    await audioRecorder.openRecorder();
    isAudioRecorderReady = true;
  }

  void cancelSignal() {
    setState(() {
      status = Status.idle;
    });
  }

  void preLaunchSignal() {
    setState(() {
      status = Status.launching;
    });
  }

  Future activateSignal() async {
    if (!isAudioRecorderReady) {
      print('Recorder is not ready');
      return;
    }
    if (sosRequest == null) {
      print('Sos request not yet initalized');
      return;
    }

    requestId = await sosRequest?.start();
    await audioRecorder.startRecorder(toFile: 'audio-${requestId!}.aac');

    setState(() {
      status = Status.active;
    });
  }

  Future stopActivatedSignal() async {
    if (!isAudioRecorderReady) {
      print('Recorder is not ready');
      return;
    }
    if (sosRequest == null) {
      print('Sos request not yet initalized');
      return;
    }

    final userId = sosRequest!.getUserId();
    final String? path = await audioRecorder.stopRecorder();
    final audioFile = File(path!);

    final String firebasePath = 'files/$userId/audio-${requestId!}.aac';
    final ref = FirebaseStorage.instance.ref().child(firebasePath);
    ref.putFile(audioFile);

    await sosRequest?.stop();

    setState(() {
      status = Status.idle;
    });
  }

  void promptStopActivatedSignal() => openConfirmationDialog().then((value) => {
        if (value == true) {stopActivatedSignal()}
      });

  Future<dynamic> openConfirmationDialog() async => showDialog(
      context: context,
      builder: (context) => const YesNoDialog(
            title: 'Stop recording',
            description: 'Are you sure want to stop recording?',
            noText: 'Cancel',
            yesText: 'Stop recording',
          ));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SosSignalHeading(status: status),
        SosButton(
          status: status,
          preLaunchSignal: preLaunchSignal,
          promptStopActivatedSignal: promptStopActivatedSignal,
          activateSignal: activateSignal,
        ),
        _SosHelpTextOrCancelBtn(status: status, onPressed: cancelSignal),
      ],
    );
  }
}
