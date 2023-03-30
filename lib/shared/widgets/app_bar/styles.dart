import 'package:flutter/material.dart';

import 'package:besafe/shared/styles.dart';

const TextStyle profileNameStyle = TextStyle(
    color: commonTextColor,
    fontFamily: 'SF-Pro-Text',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 14);

const TextStyle profilePhoneStyle = TextStyle(
  color: Color.fromRGBO(102, 102, 135, 1),
  fontFamily: 'SF-Pro-Text',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 12);

const TextStyle primaryPageTitleStyle = TextStyle(
  color: primaryColor,
  fontFamily: 'SF-Pro-Display',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
  fontSize: 32,
), secondaryPageTitleStyle = TextStyle(
  color: secondaryTextColor,
  fontFamily: 'SF-Pro-Display',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
  fontSize: 24,
);

final ButtonStyle menuButtonStyle = OutlinedButton.styleFrom(
  backgroundColor: primaryBgColor,
  shape: RoundedRectangleBorder(
      side: const BorderSide(color: primaryBorderColor, width: 1),
      borderRadius: BorderRadius.circular(12)),
);

const TextStyle menuItemTextStyle = TextStyle(
  color: hintColor,
  fontFamily: 'SF-Pro-Text',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

const TextStyle menuSubheadingStyle = TextStyle(
  color: Color.fromRGBO(102, 102, 135, 1),
  fontFamily: 'SF-Pro-Text',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
  fontSize: 11,
);