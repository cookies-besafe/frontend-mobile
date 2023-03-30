import 'package:flutter/material.dart';

import 'styles.dart';

class MainHeader extends StatelessWidget {
  final String text;
  const MainHeader({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(text, style: mainHeaderStyle);
}
