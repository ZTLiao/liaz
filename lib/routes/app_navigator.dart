import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/routes/app_route.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  static Future<T?>? toContentPage<T>(String name,
      {dynamic arg, bool replace = false}) {
    if (currentRouteName == name || replace) {
      return Get.offAndToNamed(name, arguments: arg, id: kNavigatorID);
    } else {
      return Get.toNamed(name, arguments: arg, id: kNavigatorID);
    }
  }

  static void toIndex({bool replace = false}) {
    toContentPage(AppRoute.kIndex, replace: replace);
  }

  /// 打开搜索
  static void toSearch() {
    toContentPage(AppRoute.kSearch);
  }

  static void toComicDetail(Map<String, dynamic> json, {bool replace = false}) {
    toContentPage(
      AppRoute.kComicDetail,
      arg: {
        'detail': json,
      },
      replace: replace,
    );
  }

  static Future<dynamic> toComicReader({
    required int comicChapterId,
    required List<ComicChapterModel> chapters,
  }) async {
    return toContentPage(AppRoute.kComicReader, arg: {
      'comicChapterId': comicChapterId,
      'chapters': chapters,
    });
  }

  static void toNovelDetail(Map<String, dynamic> json, {bool replace = false}) {
    toContentPage(
      AppRoute.kNovelDetail,
      arg: {
        'detail': json,
      },
      replace: replace,
    );
  }

  static void toNovelReader({
    required int novelChapterId,
    required List<NovelChapterModel> chapters,
  }) async {
    toContentPage(AppRoute.kNovelReader, arg: {
      'novelChapterId': novelChapterId,
      'chapters': chapters,
    });
  }

  static void toWebView(String url) {
    url = url.trimRight().trimLeft();
    if (Platform.isAndroid || Platform.isIOS) {
      toContentPage(AppRoute.kWebView, arg: {
        'url': url,
      });
    } else {
      launchUrlString(url);
    }
  }

  static void toUserLogin({bool replace = false}) {
    toContentPage(
      AppRoute.kUserLogin,
      replace: replace,
    );
  }

  static void toUserRegister() {
    toContentPage(AppRoute.kUserRegister);
  }

  static void toForgetPassword() {
    toContentPage(AppRoute.kForgetPassword);
  }

  static void closePage() {
    if (Navigator.canPop(Get.context!)) {
      Get.back();
    } else {
      Get.back(id: kNavigatorID);
    }
  }

  static void toComicDownload(Map<String, dynamic> json) {
    toContentPage(
      AppRoute.kComicDownload,
      arg: {
        'detail': json,
      },
    );
  }

  static void toNovelDownload(Map<String, dynamic> json) {
    toContentPage(
      AppRoute.kNovelDownload,
      arg: {
        'detail': json,
      },
    );
  }

  static void toLocalDownloadPage() {
    toContentPage(AppRoute.kLocalDownload);
  }

  static Future<dynamic> toDownloadDetailPage(
      String title, List<String> taskIds) async {
    return toContentPage(
      AppRoute.kDownloadDetail,
      arg: {
        'title': title,
        'taskIds': taskIds,
      },
    );
  }

  static void toUserDetail() {
    toContentPage(AppRoute.kUserDetail);
  }

  static void toSettings() {
    toContentPage(AppRoute.kSettings);
  }

  static void toGeneralSettings() {
    toContentPage(AppRoute.kGeneralSettings);
  }

  static void toComicSettings() {
    toContentPage(AppRoute.kComicSettings);
  }

  static void toNovelSettings() {
    toContentPage(AppRoute.kNovelSettings);
  }

  static void toSetPassword() {
    toContentPage(AppRoute.kSetPassword);
  }
}
