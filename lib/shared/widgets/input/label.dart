import 'package:flutter/material.dart';

import 'styles.dart';

class InputLabel extends StatelessWidget {
  final String text;
  const InputLabel({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: inputLabelStyle));
}
