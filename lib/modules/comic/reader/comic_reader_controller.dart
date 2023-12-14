import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/models/comic/comic_chapter_item_model.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ComicReaderController extends BaseController {
  final int comicChapterId;
  final int comicId;
  final String comicTitle;
  final String comicCover;
  final bool isLong;
  final ComicChapterItemModel chapter;
  final List<ComicChapterItemModel> chapters;

  ComicReaderController({
    required this.comicChapterId,
    required this.comicId,
    required this.comicTitle,
    required this.comicCover,
    required this.isLong,
    required this.chapter,
    required this.chapters,
  }) {
    chapterIndex.value = chapters.indexOf(chapter);
  }

  final FocusNode focusNode = FocusNode();

  /// 预加载控制器
  final PreloadPageController preloadPageController = PreloadPageController();

  /// 上下模式控制器
  final ItemScrollController itemScrollController = ItemScrollController();

  /// 监听上下滚动
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  Rx<ComicChapterItemModel> detail =
      Rx<ComicChapterItemModel>(ComicChapterItemModel.empty());

  /// 连接信息监听
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  /// 电量信息监听
  StreamSubscription<BatteryState>? batterySubscription;

  /// 当处于放大图片时，锁定滑动手势
  var lockSwipe = RxBool(false);

  /// 是否显示控制器
  var showControls = RxBool(false);

  /// 当前章节索引
  var chapterIndex = RxInt(0);

  /// 当前页面
  var currentIndex = RxInt(0);

  /// 初始化
  var initialIndex = 0;

  var direction = RxInt(0);

  bool get leftHandMode => AppSettings.comicReaderLeftHandMode.value;

  /// 翻页动画
  bool get pageAnimation => AppSettings.comicReaderPageAnimation.value;

  /// 连接类型
  Rx<ConnectivityResult> connectivityType =
      Rx<ConnectivityResult>(ConnectivityResult.other);

  /// 电量信息
  Rx<int> batteryLevel = RxInt(0);

  /// 显示电量
  RxBool showBattery = RxBool(true);

  @override
  void onInit() {
    initConnectivity();
    initBattery();
    if (isLong) {
      direction.value = ReaderDirectionEnum.upToDown.index;
    } else {
      direction.value = AppSettings.comicReaderDirection.value;
    }

    if (AppSettings.comicReaderFullScreen.value) {
      setFull();
    }
    itemPositionsListener.itemPositions.addListener(updateItemPosition);
    loadDetail();
    super.onInit();
  }

  /// 进入全屏
  void setFull() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  /// 初始化电池信息
  void initBattery() async {
    try {
      var battery = Battery();
      batterySubscription =
          battery.onBatteryStateChanged.listen((BatteryState state) async {
        try {
          var level = await battery.batteryLevel;
          batteryLevel.value = level;
          showBattery.value = true;
        } catch (e) {
          showBattery.value = false;
        }
      });
      batteryLevel.value = await battery.batteryLevel;
      showBattery.value = true;
    } catch (e) {
      showBattery.value = false;
    }
  }

  /// 初始化连接状态
  void initConnectivity() async {
    var connectivity = Connectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      //提醒
      if (connectivityType.value != result &&
          result == ConnectivityResult.mobile) {
        SmartDialog.showToast(AppString.warningFlow);
      }
      connectivityType.value = result;
    });
    connectivityType.value = await connectivity.checkConnectivity();
  }

  @override
  void onClose() {
    focusNode.dispose();
    connectivitySubscription?.cancel();
    batterySubscription?.cancel();
    exitFull();
    itemPositionsListener.itemPositions.removeListener(updateItemPosition);
    super.onClose();
  }

  void updateItemPosition() {
    var items = itemPositionsListener.itemPositions.value;
    if (items.isEmpty) {
      return;
    }
    var index = items
        .where((ItemPosition position) => position.itemTrailingEdge > 0)
        .reduce((ItemPosition min, ItemPosition position) =>
            position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
        .index;

    currentIndex.value = index;
  }

  /// 退出全屏
  void exitFull() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
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
    var value = currentIndex.value;
    Log.w("${AppString.prevPage}$value");
    if (value == 0) {
      forwardChapter();
    } else {
      jumpToPage(value - 1, anime: true);
    }
  }

  /// 上一章
  void forwardChapter() {
    if (chapterIndex.value == 0) {
      SmartDialog.showToast(AppString.frontEmpty);
      return;
    }
    chapterIndex.value -= 1;
    loadDetail();
  }

  /// 下一页
  void nextPage() {
    var value = currentIndex.value;
    Log.w("${AppString.nextPage}$value");
    var max = detail.value.paths.length;
    if (value >= max - 1) {
      nextChapter();
    } else {
      jumpToPage(value + 1, anime: true);
    }
  }

  /// 下一章
  void nextChapter() {
    if (chapterIndex.value == chapters.length - 1) {
      SmartDialog.showToast(AppString.arriveLast);
      return;
    }
    chapterIndex.value += 1;
    loadDetail();
  }

  void loadDetail() {}

  void jumpToPage(int page, {bool anime = false}) {
    //竖向
    if (direction.value == ReaderDirectionEnum.upToDown.index) {
      itemScrollController.jumpTo(index: page);
    } else {
      anime && pageAnimation
          ? preloadPageController.animateToPage(page,
              duration: const Duration(milliseconds: 200), curve: Curves.linear)
          : preloadPageController.jumpToPage(page);
    }
  }

  /// 设置显示/隐藏控制按钮
  void setShowControls() {
    if (AppSettings.comicReaderFullScreen.value) {
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
}
