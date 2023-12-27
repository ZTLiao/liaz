import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';

class NovelReaderController extends BaseController {
  final int novelChapterId;
  final List<NovelChapterModel> chapters;

  NovelReaderController({
    required this.novelChapterId,
    required this.chapters,
  });

  final FocusNode focusNode = FocusNode();

  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();

  /// 连接信息监听
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  /// 电量信息监听
  StreamSubscription<BatteryState>? batterySubscription;

  /// 连接类型
  Rx<ConnectivityResult> connectivityType =
      Rx<ConnectivityResult>(ConnectivityResult.other);

  /// 电量信息
  Rx<int> batteryLevel = RxInt(0);

  /// 显示电量
  RxBool showBattery = RxBool(true);

  /// 文本内容
  var content = RxString(StrUtil.empty);

  /// 是否显示控制器
  var showControls = RxBool(false);

  /// 当前章节索引
  var chapterIndex = RxInt(0);

  /// 当前页面
  var currentIndex = RxInt(0);

  /// 阅读方向
  var direction = RxInt(0);

  /// 最大页面
  var maxPage = RxInt(0);

  /// 阅读进度，百分比
  var progress = RxDouble(0.0);

  /// 左手模式
  bool get leftHandMode => AppSettings.novelReaderLeftHandMode.value;

  /// 翻页动画
  bool get pageAnimation => AppSettings.novelReaderPageAnimation.value;

  /// 下一章
  void nextChapter() {
    if (chapterIndex.value == chapters.length - 1) {
      SmartDialog.showToast("后面没有了");
      return;
    }
    chapterIndex.value += 1;
    loadContent();
  }

  /// 上一章
  void forwardChapter() {
    if (chapterIndex.value == 0) {
      SmartDialog.showToast("前面没有了");
      return;
    }

    chapterIndex.value -= 1;
    loadContent();
  }

  /// 下一页
  void nextPage() {
    if (direction.value == ReaderDirectionEnum.upToDown.index) {
      return;
    }
    var value = currentIndex.value;
    var max = maxPage.value;
    if (value >= max - 1) {
      nextChapter();
    } else {
      jumpToPage(value + 1, anime: true);
    }
  }

  void keyDown(LogicalKeyboardKey key) {
    if (key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.pageUp) {
      if (leftHandMode) {
        nextPage();
      } else {
        forwardPage();
      }
    } else if (key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.pageDown) {
      if (leftHandMode) {
        forwardPage();
      } else {
        nextPage();
      }
    }
  }

  /// 上一页
  void forwardPage() {
    if (direction.value == ReaderDirectionEnum.upToDown.index) {
      return;
    }
    var value = currentIndex.value;

    if (value == 0) {
      forwardChapter();
    } else {
      jumpToPage(value - 1, anime: true);
    }
  }

  void loadContent() {}

  /// 跳转页数
  void jumpToPage(int page, {bool anime = false}) {
    //竖向
    if (direction.value == ReaderDirectionEnum.upToDown.index) {
      final viewportHeight = scrollController.position.viewportDimension;
      scrollController.jumpTo(viewportHeight * page);
    } else {
      anime && pageAnimation
          ? pageController.animateToPage(
              page,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            )
          : pageController.jumpToPage(page);
    }
  }

  /// 设置显示/隐藏控制按钮
  void setShowControls() {
    if (AppSettings.novelReaderFullScreen.value) {
      if (showControls.value) {
        setFull();
      } else {
        setFullEdge();
      }
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      showControls.value = !showControls.value;
    });
  }

  /// 进入全屏
  void setFull() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  /// 进入全屏edgeToEdge模式
  void setFullEdge() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  void showMenu() {}

  void showSettings() {}
}
