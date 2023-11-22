import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liaz/app/app_color.dart';

class AppStyle {
  static final ThemeData lightTheme =
      ThemeData.light(useMaterial3: true).copyWith(
    brightness: Brightness.light,
    colorScheme: AppColor.colorSchemeLight,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColor.gray19,
      centerTitle: false,
    ),
  );

  static final ThemeData darkTheme =
      ThemeData.dark(useMaterial3: true).copyWith(
    brightness: Brightness.dark,
    primaryColor: Colors.teal,
    colorScheme: AppColor.colorSchemeDark,
    scaffoldBackgroundColor: Colors.black,
  );
}
