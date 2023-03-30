import 'package:flutter/material.dart';

import 'styles.dart';

abstract class _CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _CustomButton({required this.text, required this.onPressed, super.key});
}

class PrimaryButton extends _CustomButton {
  const PrimaryButton(
      {required super.text, required super.onPressed, super.key});

  @override
  Widget build(BuildContext context) => TextButton(
      onPressed: onPressed,
      style: primaryButtonStyle,
      child: Text(text, style: primaryButtonTextStyle));
}

class PrimaryOutlinedButton extends _CustomButton {
  const PrimaryOutlinedButton(
      {required super.text, required super.onPressed, super.key});

  @override
  Widget build(BuildContext context) => TextButton(
      onPressed: onPressed,
      style: primaryButtonOutlinedStyle,
      child: Text(text, style: primaryButtonOutlinedTextStyle));
}

class SecondaryOutlinedButton extends _CustomButton {
  const SecondaryOutlinedButton(
      {required super.text, required super.onPressed, super.key});

  @override
  Widget build(BuildContext context) => OutlinedButton(
        onPressed: onPressed,
        style: secondaryButtonOutlinedStyle,
        child: const Text('Cancel', style: secondaryButtonOutlinedTextStyle),
      );
}
