import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/device_info.dart';
import 'package:liaz/modules/common/empty_page.dart';
import 'package:liaz/modules/index/index_controller.dart';
import 'package:liaz/requests/app_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/routes/app_route.dart';
import 'package:liaz/routes/app_router.dart';
import 'package:liaz/services/device_info_service.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    //转发至Zone中
    Zone.current
        .handleUncaughtError(details.exception, (details.stack as StackTrace));
  };
  runZonedGuarded(() async {
    //初始化
    await init();
    runApp(const LiazApp());
  }, (error, stack) {
    //全局异常捕获
    Log.e(error.toString(), stack);
  });
}

Future<void> init() async {
  //初始化数据库
  await initHive();
  //初始化服务
  await initServices();
  AppRequest().clientInit();
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DeviceInfoAdapter());
  await Get.put(DeviceInfoService()).init();
}

Future<void> initServices() async {
  Global.packageInfo = await PackageInfo.fromPlatform();
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
      initialRoute: AppRoute.kIndex,
      getPages: AppRouter.routes,
      onUnknownRoute: (settings) => GetPageRoute(
        page: () => const EmptyPage(),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        //iOS
      ],
      navigatorKey: AppNavigator.navigatorKey,
      navigatorObservers: [
        AppNavigatorObserver(),
        FlutterSmartDialog.observer,
      ],
      builder: FlutterSmartDialog.init(
        loadingBuilder: ((msg) => const AppLoadingWidget()),
      ),
    );
  }
}

/// 路由监听
class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      var routeName = route.settings.name ?? StrUtil.empty;
      AppNavigator.currentRouteName = routeName;
      Get.find<IndexController>().showContent.value =
          routeName != AppRoute.kRoot;
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    var routeName = previousRoute?.settings.name ?? StrUtil.empty;
    AppNavigator.currentRouteName = routeName;
    Get.find<IndexController>().showContent.value = routeName != AppRoute.kRoot;
  }
}
