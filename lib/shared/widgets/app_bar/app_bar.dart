import 'package:besafe/shared/styles.dart';
import 'package:besafe/shared/widgets/app_bar/styles.dart';
import 'package:flutter/material.dart';

import 'components.dart';

enum TitleType { primary, secondary }

class BeSafeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String titleText;
  final TitleType titleType;
  final bool backButton;

  const BeSafeAppBar(
      {required this.titleText,
      required this.titleType,
      this.backButton = false,
      Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  State<BeSafeAppBar> createState() => _BeSafeAppBarState();
}

class _BeSafeAppBarState extends State<BeSafeAppBar> {
  static const Map<TitleType, TextStyle> headerStyles = {
    TitleType.primary: primaryPageTitleStyle,
    TitleType.secondary: secondaryPageTitleStyle,
  };

  Widget getHeader() => Container(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.titleText,
          style: headerStyles[widget.titleType],
          textAlign: TextAlign.center,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.backButton
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.chevron_left, color: secondaryTextColor))
          : null,
      title: getHeader(),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 56,
      actions: <Widget>[
        // Wrap in a builder to correctly extract scaffold
        Builder(builder: (context) {
          return MenuButton(scaffoldState: Scaffold.of(context));
        }),
      ],
    );
  }
}
