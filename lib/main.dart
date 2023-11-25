import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/routes/app_route_path.dart';
import 'package:liaz/routes/app_router.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    //转发至Zone中
    Zone.current
        .handleUncaughtError(details.exception, (details.stack as StackTrace));
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
    return GetMaterialApp(
      title: AppString.appName,
      scrollBehavior: AppScrollBehavior(),
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      initialRoute: AppRoutePath.kHome,
      getPages: AppRouter.routes,
      builder: FlutterSmartDialog.init(
          loadingBuilder: ((msg) => const AppLoadingWidget())),
    );
  }
}
