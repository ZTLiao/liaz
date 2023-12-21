import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/models/comic/comic_chapter_item_model.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
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

  static void toComicDetail(Map<String, dynamic> json) {
    toContentPage(AppRoute.kComicDetail, arg: {
      'detail': json,
    });
  }

  static void toComicReader({
    required int comicChapterId,
    required int comicId,
    required String comicTitle,
    required String comicCover,
    required bool isLong,
    required ComicChapterItemModel chapter,
    required List<ComicChapterModel> chapters,
  }) async {
    await Get.toNamed(AppRoute.kComicReader, arguments: {
      'comicChapterId': comicChapterId,
      'comicId': comicId,
      'comicTitle': comicTitle,
      'comicCover': comicCover,
      'isLong': isLong,
      'chapter': chapter,
      'chapters': chapters,
    });
  }

  static void toNovelDetail(int novelId) {
    toContentPage(AppRoute.kNovelDetail, arg: {
      'id': novelId,
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
}
