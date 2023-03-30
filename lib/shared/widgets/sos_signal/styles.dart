import 'package:besafe/shared/styles.dart';
import 'package:flutter/material.dart';

final ButtonStyle sosButtonIdleStyle = OutlinedButton.styleFrom(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: primaryBorderColor, width: 1),
          borderRadius: BorderRadius.circular(100)),
    ),
    sosButtonActiveStyle = OutlinedButton.styleFrom(
      backgroundColor: primaryBgColor,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: primaryBorderColor, width: 1),
          borderRadius: BorderRadius.circular(100)),
    );

const TextStyle sosButtonHeadingStyle = TextStyle(
  color: secondaryTextColor,
  fontFamily: 'SF-Pro-Display',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
  fontSize: 24,
);

const TextStyle sosIdleTextStyle = TextStyle(
        color: Colors.white,
        fontFamily: 'SF-Pro-Display',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: 64),
    sosActiveTextStyle = TextStyle(
        color: primaryColor,
        fontFamily: 'SF-Pro-Display',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: 64);

const TextStyle sosHelpTextStyle = TextStyle(
    color: hintColor,
    fontFamily: 'SF-Pro-Text',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 14);
