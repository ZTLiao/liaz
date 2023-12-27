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

  static Map<int, List<Color>> novelThemes = {
    0: [
      const Color.fromRGBO(245, 239, 217, 1),
      const Color(0xff301e1b),
    ],
    1: [
      const Color.fromRGBO(248, 247, 252, 1),
      black33,
    ],
    2: [
      const Color.fromRGBO(192, 237, 198, 1),
      Colors.black,
    ],
    3: [
      const Color(0xff3b3a39),
      const Color.fromRGBO(230, 230, 230, 1),
    ],
    4: [
      Colors.black,
      const Color.fromRGBO(200, 200, 200, 1),
    ],
  };
}
