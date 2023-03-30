import 'package:flutter/material.dart';

import 'styles.dart';

class MenuItem extends StatelessWidget {
  final String iconName, text;
  final VoidCallback onTap;

  const MenuItem(
      {required this.iconName,
        required this.text,
        required this.onTap,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/menu_icons/$iconName',
              width: 14,
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(text, style: menuItemTextStyle),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class MenuSubheading extends StatelessWidget {
  final String text;

  const MenuSubheading({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 20, bottom: 12),
      alignment: Alignment.centerLeft,
      child: Text(text.toUpperCase(), style: menuSubheadingStyle),
    );
  }
}

class MenuButton extends StatelessWidget {
  final ScaffoldState scaffoldState;

  const MenuButton({required this.scaffoldState, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 50,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: OutlinedButton(
        onPressed: () => scaffoldState.openEndDrawer(),
        style: menuButtonStyle,
        child: Image.asset('assets/images/menu-icon.png'),
      ),
    );
  }
}