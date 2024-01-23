import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/app_config.dart';
import 'package:liaz/models/db/comic.dart';
import 'package:liaz/models/db/comic_chapter.dart';
import 'package:liaz/models/db/device_info.dart';
import 'package:liaz/models/db/file_item.dart';
import 'package:liaz/models/db/novel.dart';
import 'package:liaz/models/db/novel_chapter.dart';
import 'package:liaz/models/db/oauth2_token.dart';
import 'package:liaz/models/db/search.dart';
import 'package:liaz/models/db/task.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/modules/common/empty_page.dart';
import 'package:liaz/modules/common/splash/splash_screen_page.dart';
import 'package:liaz/requests/crash_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/routes/app_route.dart';
import 'package:liaz/routes/app_router.dart';
import 'package:liaz/services/app_config_service.dart';
import 'package:liaz/services/app_settings_service.dart';
import 'package:liaz/services/comic_chapter_service.dart';
import 'package:liaz/services/comic_download_service.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/device_info_service.dart';
import 'package:liaz/services/local_storage_service.dart';
import 'package:liaz/services/novel_chapter_service.dart';
import 'package:liaz/services/novel_download_service.dart';
import 'package:liaz/services/novel_service.dart';
import 'package:liaz/services/oauth2_token_service.dart';
import 'package:liaz/services/recommend_service.dart';
import 'package:liaz/services/search_service.dart';
import 'package:liaz/services/task_service.dart';
import 'package:liaz/services/user_service.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    //转发至Zone中
    Zone.current
        .handleUncaughtError(details.exception, (details.stack as StackTrace));
  };
  var crashRequest = CrashRequest();
  runZonedGuarded(() async {
    //初始化
    await init();
    runApp(const LiazApp());
  }, (error, stackTrace) {
    Log.e(error.toString(), stackTrace);
    //全局异常捕获
    Log.logPrint(stackTrace);
    //上报崩溃日志
    crashRequest.report(error.toString(), stackTrace);
  });
}

Future<void> init() async {
  //初始化数据库
  await initHive();
  //初始化服务
  await initServices();
  //设置状态栏为透明
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Global.packageInfo = await PackageInfo.fromPlatform();
  Hive.registerAdapter(DeviceInfoAdapter());
  Hive.registerAdapter(AppConfigAdapter());
  Hive.registerAdapter(OAuth2TokenAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SearchAdapter());
  Hive.registerAdapter(ComicAdapter());
  Hive.registerAdapter(NovelAdapter());
  Hive.registerAdapter(ComicChapterAdapter());
  Hive.registerAdapter(NovelChapterAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(FileItemAdapter());
}

Future<void> initServices() async {
  await Get.put(DeviceInfoService()).init();
  await Get.put(AppConfigService()).init();
  Get.put(LocalStorageService())
      .init()
      .then((value) => Get.put(AppSettingsService()).init());
  Get.put(OAuth2TokenService()).init();
  Get.put(UserService())
      .init()
      .then((value) => UserService.instance.refreshToken());
  Get.put(SearchService()).init();
  Get.put(ComicService()).init();
  Get.put(NovelService()).init();
  Get.put(ComicChapterService()).init();
  Get.put(NovelChapterService()).init();
  Get.put(TaskService()).init().then((value) {
    Get.put(ComicDownloadService()).init();
    Get.put(NovelDownloadService()).init();
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
    bool hasSplash = false;
    return GetMaterialApp(
      title: AppString.appName,
      scrollBehavior: AppScrollBehavior(),
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      home: hasSplash ? SplashScreenPage() : null,
      initialRoute: hasSplash ? null : AppRoute.kIndex,
      getPages: AppRouter.routes,
      debugShowCheckedModeBanner: false,
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
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    var routeName = previousRoute?.settings.name ?? StrUtil.empty;
    AppNavigator.currentRouteName = routeName;
  }
}
