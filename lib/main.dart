import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liaz/app/app_string.dart';
import 'package:liaz/app/app_style.dart';
import 'package:liaz/app/log.dart';
import 'package:liaz/routes/app_route_path.dart';
import 'package:liaz/routes/app_router.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    //转发至Zone中
    Zone.current.handleUncaughtError(details.exception, (details.stack as StackTrace));
  };
  runZonedGuarded(() => runApp(const LiazApp()), (error, stack) {
    //全局异常捕获
    Log.e(error.toString(), stack);
  });
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}

class LiazApp extends StatelessWidget {
  const LiazApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appName,
      scrollBehavior: AppScrollBehavior(),
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      initialRoute: AppRoutePath.kHome,
      routes: AppRouter.routes,
    );
  }
}
