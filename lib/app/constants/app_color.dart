import 'package:flutter/material.dart';

class AppColor {
  static final ColorScheme colorSchemeLight = ColorScheme.fromSwatch(
    primarySwatch: Colors.cyan,
    brightness: Brightness.light,
  );

  static final ColorScheme colorSchemeDark = ColorScheme.fromSwatch(
    primarySwatch: Colors.cyan,
    accentColor: Colors.cyan,
    backgroundColor: Colors.cyan,
    brightness: Brightness.dark,
  );

  static const Color backgroundColor = Color(0xfffafafa);
  static const Color backgroundColorDark = Color(0xff212121);
  static const Color black33 = Color(0xff333333);
  static const Color greyf0 = Color(0xfff0f0f0);
  static const Color grey99 = Color(0xff999999);
}
