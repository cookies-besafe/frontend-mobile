import 'package:flutter/material.dart';

OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color.fromRGBO(206, 212, 218, 1)),
    borderRadius: BorderRadius.circular(12.0));

const TextStyle inputHintStyle = TextStyle(
    color: Color.fromRGBO(73, 181, 189, 1),
    fontFamily: 'SF-Pro-Text',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 14.0);

const TextStyle inputLabelStyle = TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 12.0,
    color: Color.fromRGBO(52, 58, 64, 1));

const Color searchLabelColor = Color.fromRGBO(142, 142, 169, 1);
const TextStyle searchLabelTextStyle = TextStyle(
  color: searchLabelColor,
  fontFamily: 'SF-Pro-Text',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 16,
), searchInputTextStyle = TextStyle(
  color: Color.fromRGBO(52, 58, 64, 1),
  fontFamily: 'SF-Pro-Text',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 16,
);
final OutlineInputBorder searchBorderStyle = OutlineInputBorder(
  borderSide: const BorderSide(color: Color.fromRGBO(234, 234, 239, 1)),
  borderRadius: BorderRadius.circular(12),
);
