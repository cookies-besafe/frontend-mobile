import 'package:flutter/material.dart';

import 'label.dart';

class AlignedInputField extends StatelessWidget {
  final Widget widget;

  const AlignedInputField({required this.widget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: SizedBox(height: 40.0, child: widget),
    );
}

class InputEntry extends StatelessWidget {
  final String text;
  final Widget widget;

  const InputEntry(
      {required this.text, required this.widget, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: <Widget>[InputLabel(text: text), widget],
      ),
    );
}
