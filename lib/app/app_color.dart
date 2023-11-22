import 'package:flutter/material.dart';

class AppColor {

  static final ColorScheme colorSchemeLight = ColorScheme.fromSwatch(
    primarySwatch: Colors.cyan,
    brightness: Brightness.light,
  );

  static final ColorScheme colorSchemeDark = ColorScheme.fromSwatch(
    primarySwatch: Colors.teal,
    accentColor: Colors.teal,
    backgroundColor: Colors.teal,
    brightness: Brightness.dark,
  );

  static const Color gray19 = Color(0xff333333);
}