import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/enums/screen_direction_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/models/comic/comic_chapter_item_model.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/routes/app_route.dart';
import 'package:liaz/services/app_config_service.dart';
import 'package:liaz/services/app_settings_service.dart';
import 'package:liaz/services/comic_download_service.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:path/path.dart' as path;

class ComicReaderController extends BaseController {
  final int comicChapterId;

  final List<ComicChapterModel> chapters;

  ComicReaderController({
    required this.comicChapterId,
    required this.chapters,
  }) {
    int i = 0;
    for (int len = chapters.length; i < len; i++) {
      if (chapters[i].comicChapterId == comicChapterId) {
        break;
      }
    }
    chapterIndex.value = i;
    isLocal.value = chapters[i].isLocal;
    loadDetail();
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

  /// 阅读方向
  var readDirection = RxInt(0);

  ///屏幕亮度
  var screenBrightness = RxDouble(0);

  ///是否本地
  var isLocal = RxBool(false);

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

  /// 屏幕方向
  RxInt screenDirection = RxInt(0);

  @override
  void onInit() {
    initConnectivity();
    initBattery();
    readDirection.value = AppSettings.comicReaderDirection.value;
    screenBrightness.value = AppSettings.screenBrightness.value;
    if (detail.value.isLong) {
      readDirection.value = ReaderDirectionEnum.upToDown.index;
    }
    screenDirection.value = AppSettings.comicScreenDirection.value;
    if (AppSettings.comicReaderFullScreen.value) {
      setFull();
    }
    itemPositionsListener.itemPositions.addListener(updateItemPosition);
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
    if (!isLocal.value) {
      ComicService.instance.uploadHistory(
        detail.value.comicId,
        AssetTypeEnum.comic.index,
        comicChapterId,
        detail.value.chapterName,
        detail.value.paths[currentIndex.value],
        currentIndex.value,
      );
    }
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

  void loadDetail() async {
    if (chapters.isEmpty) {
      return;
    }
    var comicChapter = chapters[chapterIndex.value];

    for (int i = 0; i < comicChapter.paths.length; i++) {
      if (isLocal.value) {
        comicChapter.paths[i] = path.join(
            ComicDownloadService.instance.savePath, comicChapter.paths[i]);
      } else {
        comicChapter.paths[i] =
            await AppConfigService.instance.getObject(comicChapter.paths[i]);
      }
    }
    detail.value = ComicChapterItemModel(
      comicChapterId: comicChapter.comicChapterId,
      comicId: comicChapter.comicId,
      flag: comicChapter.flag,
      chapterName: comicChapter.chapterName,
      seqNo: comicChapter.seqNo,
      paths: comicChapter.paths,
      direction: comicChapter.direction,
      isLocal: comicChapter.isLocal,
    );
    currentIndex.value = comicChapter.currentIndex;
    isLocal.value = comicChapter.isLocal;
    Future.delayed(const Duration(milliseconds: 100), () {
      jumpToPage(currentIndex.value);
    });
  }

  void jumpToPage(int page, {bool anime = false}) {
    //竖向
    if (readDirection.value == ReaderDirectionEnum.upToDown.index) {
      if (itemScrollController.isAttached) {
        itemScrollController.jumpTo(index: page);
      }
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

  /// 显示目录
  void showCatalogue() async {
    setShowControls();
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      backgroundColor: AppStyle.darkTheme.scaffoldBackgroundColor.withOpacity(0.7),
      builder: (context) => Theme(
        data: AppStyle.darkTheme,
        child: Column(
          children: [
            ListTile(
              title: Text('${AppString.catalogue}(${chapters.length})'),
              contentPadding: AppStyle.edgeInsetsL12,
            ),
            Divider(
              height: 1.0,
              color: Colors.grey.withOpacity(.2),
            ),
            Expanded(
              child: ScrollablePositionedList.separated(
                initialScrollIndex: chapterIndex.value,
                itemCount: chapters.length,
                separatorBuilder: (_, i) => Divider(
                  indent: 12,
                  endIndent: 12,
                  height: 1.0,
                  color: Colors.grey.withOpacity(.2),
                ),
                itemBuilder: (_, i) {
                  var item = chapters[i];
                  return ListTile(
                    selected: i == chapterIndex.value,
                    title: Text(item.chapterName),
                    subtitle: item.updatedAt != 0
                        ? Text(
                            '${AppString.updateAt}${DateUtil.formatDate(item.updatedAt)}',
                          )
                        : null,
                    onTap: () {
                      chapterIndex.value = i;
                      loadDetail();
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      routeSettings: const RouteSettings(
        name: AppRoute.kModalBottomSheet,
      ),
    );
  }

  onDetail() {
    ComicService.instance.toComicDetail(
      detail.value.comicId,
      replace: true,
    );
  }

  void showSettings() {
    setShowControls();
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      constraints: const BoxConstraints(
        maxHeight: 240,
      ),
      backgroundColor: Colors.black.withOpacity(0.7),
      builder: (context) => Theme(
        data: AppStyle.darkTheme,
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.nights_stay_outlined),
                      title: Slider.adaptive(
                        value: screenBrightness.value,
                        onChanged: (value) {
                          screenBrightness.value = value;
                          AppSettingsService.instance
                              .setScreenBrightness(value);
                        },
                      ),
                      trailing: const Icon(Icons.wb_sunny_outlined),
                    ),
                    ListTile(
                      leading: const Text(
                        AppString.readDirection,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            value: ReaderDirectionEnum.leftToRight.index,
                            groupValue: readDirection.value,
                            onChanged: (value) {
                              readDirection.value = value!;
                              AppSettingsService.instance
                                  .setComicReaderDirection(value);
                            },
                          ),
                          Text(
                            AppString.rightToLeft,
                            style: TextStyle(
                              color: readDirection.value ==
                                      ReaderDirectionEnum.leftToRight.index
                                  ? Colors.cyan
                                  : Colors.white,
                            ),
                          ),
                          Radio(
                            value: ReaderDirectionEnum.rightToLeft.index,
                            groupValue: readDirection.value,
                            onChanged: (value) {
                              readDirection.value = value!;
                              AppSettingsService.instance
                                  .setComicReaderDirection(value);
                            },
                          ),
                          Text(
                            AppString.rightToLeft,
                            style: TextStyle(
                              color: readDirection.value ==
                                      ReaderDirectionEnum.rightToLeft.index
                                  ? Colors.cyan
                                  : Colors.white,
                            ),
                          ),
                          Radio(
                            value: ReaderDirectionEnum.upToDown.index,
                            groupValue: readDirection.value,
                            onChanged: (value) {
                              readDirection.value = value!;
                              AppSettingsService.instance
                                  .setComicReaderDirection(value);
                            },
                          ),
                          Text(
                            AppString.upToDown,
                            style: TextStyle(
                              color: readDirection.value ==
                                      ReaderDirectionEnum.upToDown.index
                                  ? Colors.cyan
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Text(
                        AppString.screenDirection,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              screenDirection.value =
                                  ScreenDirectionEnum.vertical.index;
                              AppSettingsService.instance
                                  .setComicScreenDirection(
                                      ScreenDirectionEnum.vertical.index);
                            },
                            style: ButtonStyle(
                              side: MaterialStatePropertyAll(
                                BorderSide(
                                  color: screenDirection.value ==
                                          ScreenDirectionEnum.vertical.index
                                      ? Colors.cyan
                                      : Colors.white,
                                ),
                              ),
                            ),
                            child: Text(
                              AppString.verticalScreenRead,
                              style: TextStyle(
                                color: screenDirection.value ==
                                        ScreenDirectionEnum.vertical.index
                                    ? Colors.cyan
                                    : Colors.white,
                              ),
                            ),
                          ),
                          AppStyle.hGap4,
                          TextButton(
                            onPressed: () {
                              screenDirection.value =
                                  ScreenDirectionEnum.horizontal.index;
                              AppSettingsService.instance
                                  .setComicScreenDirection(
                                      ScreenDirectionEnum.horizontal.index);
                            },
                            style: ButtonStyle(
                              side: MaterialStatePropertyAll(
                                BorderSide(
                                  color: screenDirection.value ==
                                          ScreenDirectionEnum.horizontal.index
                                      ? Colors.cyan
                                      : Colors.white,
                                ),
                              ),
                            ),
                            child: Text(
                              AppString.horizontalScreenRead,
                              style: TextStyle(
                                color: screenDirection.value ==
                                        ScreenDirectionEnum.horizontal.index
                                    ? Colors.cyan
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
