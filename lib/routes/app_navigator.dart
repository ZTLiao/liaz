import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/routes/app_route.dart';

class AppNavigator {
  static String currentRouteName = AppRoute.kRoot;

  /// 路由ID
  static const int kNavigatorID = 1;

  /// 路由Key
  static final GlobalKey<NavigatorState>? navigatorKey =
      Get.nestedKey(kNavigatorID);

  /// 路由的Context
  static BuildContext get navigatorContext => navigatorKey!.currentContext!;

  static void toPage(String name, {dynamic arg}) {
    Get.toNamed(name, arguments: arg);
  }

  /// 跳转子路由页面
  static void toContentPage(String name, {dynamic arg, bool replace = false}) {
    if (currentRouteName == name && replace) {
      Get.offAndToNamed(name, arguments: arg, id: kNavigatorID);
    } else {
      Get.toNamed(name, arguments: arg, id: kNavigatorID);
    }
  }

  /// 打开搜索
  static void toSearch() {
    toContentPage(AppRoute.kSearch);
  }

  static void toComicDetail(int comicId) {
    toContentPage(AppRoute.kComicDetail, arg: {
      'id': comicId,
    });
  }

  static void toNovelDetail(int novelId) {
    toContentPage(AppRoute.kNovelDetail, arg: {
      'id': novelId,
    });
  }
}
