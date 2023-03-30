import 'package:besafe/shared/styles.dart';
import 'package:flutter/material.dart';

abstract class _SwitchAccountActionWidget extends StatelessWidget {
  final String messageText, actionText, actionRoute;
  final double bottomMargin;

  const _SwitchAccountActionWidget(
      {required this.messageText,
      required this.actionText,
      required this.actionRoute,
      required this.bottomMargin,
      super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: bottomMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              messageText,
              style: const TextStyle(
                  fontFamily: 'SF-Pro-Text',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: hintColor),
            ),
            TextButton(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, actionRoute),
                child: Text(
                  actionText,
                  style: const TextStyle(
                      fontFamily: 'SF-Pro-Text',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: primaryColor),
                ))
          ],
        ),
      );
}

class DoNotHaveAnAccountWidget extends _SwitchAccountActionWidget {
  const DoNotHaveAnAccountWidget({super.key})
      : super(
            messageText: "Don't have an account?",
            actionText: 'Sign up',
            actionRoute: '/registration',
            bottomMargin: 30);
}

class AlreadyHaveAnAccountWidget extends _SwitchAccountActionWidget {
  const AlreadyHaveAnAccountWidget({super.key})
      : super(
            messageText: 'Already have an account?',
            actionText: 'Sign in',
            actionRoute: '/login',
            bottomMargin: 10);
}
