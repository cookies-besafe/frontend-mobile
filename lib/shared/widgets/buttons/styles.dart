import 'package:besafe/shared/styles.dart';
import 'package:flutter/material.dart';

const TextStyle secondaryButtonOutlinedTextStyle = TextStyle(
        color: commonTextColor,
        fontFamily: 'SF-Pro-Text',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: 14),
    primaryButtonTextStyle = TextStyle(
        color: Colors.white,
        fontFamily: 'SF-Pro-Text',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: 14),
    primaryButtonOutlinedTextStyle = TextStyle(
      color: primaryColor,
      fontFamily: 'SF-Pro-Text',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );

final ButtonStyle secondaryButtonOutlinedStyle = OutlinedButton.styleFrom(
        side: const BorderSide(color: Color.fromRGBO(220, 220, 228, 1)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    primaryButtonStyle = TextButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    primaryButtonOutlinedStyle = TextButton.styleFrom(
      backgroundColor: primaryBgColor,
      side: const BorderSide(color: primaryBorderColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));
