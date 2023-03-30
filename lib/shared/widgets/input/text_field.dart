import 'package:flutter/material.dart';

import 'formatting.dart';
import 'styles.dart';

class FormattedTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool obscureText;

  const FormattedTextField(
      {required this.text,
      required this.controller,
      this.obscureText = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => AlignedInputField(
      widget: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: text,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              hintStyle: inputHintStyle,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              floatingLabelBehavior: FloatingLabelBehavior.never)),
    );
}
