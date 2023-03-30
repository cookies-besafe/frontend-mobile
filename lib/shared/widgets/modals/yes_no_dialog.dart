import 'package:besafe/shared/styles.dart';
import 'package:besafe/shared/widgets.dart';
import 'package:flutter/material.dart';

import 'styles.dart';

class YesNoDialog extends StatelessWidget {
  final String title, description, yesText, noText;

  const YesNoDialog(
      {required this.title,
      required this.description,
      required this.yesText,
      required this.noText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text(title, style: modalTitleStyle),
            ),
            const Divider(
              color: dividerColor,
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              child: Text(
                description,
                style: modalDescriptionStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              color: dividerColor,
              thickness: 1,
              height: 1,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                child: Row(children: [
                  Expanded(
                      child: SecondaryOutlinedButton(
                          text: noText,
                          onPressed: () => Navigator.pop(context, false))),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 3.5)),
                  Expanded(
                    child: PrimaryOutlinedButton(
                        text: yesText,
                        onPressed: () => Navigator.pop(context, true)),
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
