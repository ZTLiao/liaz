import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/file_type.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/http/request.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/novel/novel_chapter_item_model.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/services/app_config_service.dart';

class NovelReaderController extends BaseController {
  final int novelChapterId;
  final List<NovelChapterModel> chapters;

  NovelReaderController({
    required this.novelChapterId,
    required this.chapters,
  }) {
    int i = 0;
    for (int len = chapters.length; i < len; i++) {
      if (chapters[i].novelChapterId == novelChapterId) {
        break;
      }
    }
    chapterIndex.value = i;
  }

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

  Rx<NovelChapterItemModel> detail =
      Rx<NovelChapterItemModel>(NovelChapterItemModel.empty());

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

  @override
  void onInit() {
    initConnectivity();
    initBattery();
    direction.value = AppSettings.novelReaderDirection.value;
    scrollController.addListener(listenVertical);
    setFull();
    loadContent();
    super.onInit();
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

  /// 监听竖向模式时滚动百分比
  void listenVertical() {
    if (scrollController.position.maxScrollExtent > 0) {
      progress.value = scrollController.position.pixels /
          scrollController.position.maxScrollExtent;
    }
  }

  /// 下一章
  void nextChapter() {
    if (chapterIndex.value == chapters.length - 1) {
      SmartDialog.showToast(AppString.arriveLast);
      return;
    }
    chapterIndex.value += 1;
    loadContent();
  }

  /// 上一章
  void forwardChapter() {
    if (chapterIndex.value == 0) {
      SmartDialog.showToast(AppString.frontEmpty);
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

  void loadContent() async {
    content.value = StrUtil.empty;
    var chapter = chapters[chapterIndex.value];
    var paths = chapter.paths;
    var types = chapter.types;
    var sb = StringBuffer();
    for (int i = 0; i < paths.length; i++) {
      var path = paths[i];
      var type = types[i];
      if (type == FileType.textPlain) {
        path = await AppConfigService.instance.getObject(path);
        sb.write(await Request.instance.getResource(path));
      }
    }
    content.value = sb.toString();
    detail.value = NovelChapterItemModel(
      novelChapterId: novelChapterId,
      novelId: chapter.novelId,
      flag: chapter.flag,
      chapterName: chapter.chapterName,
      seqNo: chapter.seqNo,
      paths: paths,
      types: types,
      direction: chapter.direction,
    );
  }

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
