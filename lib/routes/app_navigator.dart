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
  static Future<dynamic> toContentPage(String name,
      {dynamic arg, bool replace = false}) async {
    if (currentRouteName == name || replace) {
      return await Get.offAndToNamed(name, arguments: arg, id: kNavigatorID);
    } else {
      return await Get.toNamed(name, arguments: arg, id: kNavigatorID);
    }
  }

  static Future<dynamic> toIndex({bool replace = false}) async {
    return toContentPage(AppRoute.kIndex, replace: replace);
  }

  /// 打开搜索
  static void toSearch() {
    toContentPage(AppRoute.kSearch);
  }

  static Future<void> toComicDetail(Map<String, dynamic> json,
      {bool replace = false}) async {
    return await toContentPage(
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

  static Future<void> toNovelDetail(Map<String, dynamic> json,
      {bool replace = false}) async {
    return await toContentPage(
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

  static Future<dynamic> toWebView(String url) async {
    url = url.trimRight().trimLeft();
    if (Platform.isAndroid || Platform.isIOS) {
      return await toContentPage(AppRoute.kWebView, arg: {
        'url': url,
      });
    } else {
      return await launchUrlString(url);
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

  static closePage<T>({T? result}) {
    if (Navigator.canPop(Get.context!)) {
      return Get.back(
        result: result,
      );
    } else {
      return Get.back(
        result: result,
        id: kNavigatorID,
      );
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

  static Future<dynamic> toUserDetail() async {
    return toContentPage(AppRoute.kUserDetail);
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

  static void toBrowseHistory() {
    toContentPage(AppRoute.kBrowseHistory);
  }

  static void toMessageBoard() {
    toContentPage(AppRoute.kMessageBoard);
  }
}
