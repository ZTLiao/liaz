import 'dart:async';
import 'dart:io';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/constants/bucket_constant.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/enums/screen_direction_enum.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/novel/novel_chapter_item_model.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/routes/app_route.dart';
import 'package:liaz/services/app_settings_service.dart';
import 'package:liaz/services/file_item_service.dart';
import 'package:liaz/services/novel_download_service.dart';
import 'package:liaz/services/novel_service.dart';
import 'package:liaz/widgets/toolbar/number_controller_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:path/path.dart' as path;

class NovelReaderController extends BaseController {
  int novelChapterId;
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
    isLocal.value = chapters[i].isLocal;
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

  /// 图片
  var pictures = RxList<String>([]);

  /// 是否全是图片
  var isAllPicture = RxBool(false);

  /// 是否显示控制器
  var showControls = RxBool(false);

  /// 当前章节索引
  var chapterIndex = RxInt(0);

  /// 当前页面
  var currentIndex = RxInt(0);

  /// 阅读方向
  var readDirection = RxInt(0);

  /// 最大页面
  var maxPage = RxInt(0);

  /// 阅读进度，百分比
  var progress = RxDouble(0.0);

  ///屏幕亮度
  var screenBrightness = RxDouble(0);

  /// 屏幕方向
  RxInt screenDirection = RxInt(0);

  /// 是否为本地
  var isLocal = RxBool(false);

  /// 左手模式
  bool get leftHandMode => AppSettings.novelReaderLeftHandMode.value;

  /// 翻页动画
  bool get pageAnimation => AppSettings.novelReaderPageAnimation.value;

  @override
  void onInit() {
    initConnectivity();
    initBattery();
    readDirection.value = AppSettings.novelReaderDirection.value;
    screenBrightness.value = AppSettings.screenBrightness.value;
    screenDirection.value = AppSettings.screenDirection.value;
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
    if (readDirection.value == ReaderDirectionEnum.upToDown.index) {
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
    if (readDirection.value == ReaderDirectionEnum.upToDown.index) {
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
      if (isLocal.value) {
        if (paths[i].contains(BucketConstant.novel)) {
          sb.write(await File(
                  path.join(NovelDownloadService.instance.savePath, paths[i]))
              .readAsString());
        } else if (paths[i].contains(BucketConstant.inset)) {
          pictures.add(paths[i]);
        }
      } else {
        if (paths[i].contains(BucketConstant.novel)) {
          sb.write(await NovelService.instance.getContent(paths[i]));
        } else if (paths[i].contains(BucketConstant.inset)) {
          paths[i] = await FileItemService.instance.getObject(paths[i]);
          pictures.add(paths[i]);
        }
      }
    }
    isAllPicture.value = pictures.isNotEmpty && sb.isEmpty;
    content.value = sb.toString();
    detail.value = NovelChapterItemModel(
      novelChapterId: chapter.novelChapterId,
      novelId: chapter.novelId,
      flag: chapter.flag,
      chapterName: chapter.chapterName,
      seqNo: chapter.seqNo,
      paths: paths,
      types: types,
      direction: chapter.direction,
      isLocal: chapter.isLocal,
    );
    isLocal.value = chapter.isLocal;
    novelChapterId = chapter.novelChapterId;
    if (chapter.currentIndex != 0) {
      currentIndex.value = chapter.currentIndex;
    }
  }

  /// 跳转页数
  void jumpToPage(int page, {bool anime = false}) {
    //竖向
    if (readDirection.value == ReaderDirectionEnum.upToDown.index) {
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
      backgroundColor:
          AppStyle.darkTheme.scaffoldBackgroundColor.withOpacity(0.7),
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
                      loadContent();
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

  @override
  void onClose() {
    var path = StrUtil.empty;
    var paths = detail.value.paths;
    if (paths.isNotEmpty) {
      path = detail.value.paths[0];
    }
    if (!isLocal.value) {
      NovelService.instance.uploadHistory(
        detail.value.novelId,
        AssetTypeEnum.novel.index,
        detail.value.novelChapterId,
        detail.value.chapterName,
        path,
        currentIndex.value,
      );
    }
    scrollController.removeListener(listenVertical);
    connectivitySubscription?.cancel();
    batterySubscription?.cancel();
    exitFull();
    super.onClose();
  }

  /// 退出全屏
  void exitFull() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
  }

  void onDetail() {
    NovelService.instance.toNovelDetail(
      detail.value.novelId,
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
        maxHeight: 350,
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
                                  .setNovelReaderDirection(value);
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
                                  .setNovelReaderDirection(value);
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
                                  .setNovelReaderDirection(value);
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
                        AppString.readTheme,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: AppColor.novelThemes.keys
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  AppSettingsService.instance
                                      .setNovelReaderTheme(e);
                                },
                                child: Container(
                                  margin: AppStyle.edgeInsetsL24,
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    color: AppColor.novelThemes[e]!.first,
                                    borderRadius: AppStyle.radius24,
                                  ),
                                  child: Visibility(
                                    visible: AppColor.novelThemes.keys
                                            .toList()
                                            .indexOf(e) ==
                                        AppSettings.novelReaderTheme.value,
                                    child: Icon(
                                      Icons.check,
                                      color: AppColor.novelThemes[e]!.last,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    ListTile(
                      leading: const Text(
                        AppString.fontSize,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NumberControllerWidget(
                            numText: '${AppSettings.novelReaderFontSize.value}',
                            width: 100,
                            addValueChanged: (value) {
                              AppSettingsService.instance
                                  .setNovelReaderFontSize(
                                AppSettings.novelReaderFontSize.value + 1,
                              );
                            },
                            removeValueChanged: (value) {
                              AppSettingsService.instance
                                  .setNovelReaderFontSize(
                                AppSettings.novelReaderFontSize.value - 1,
                              );
                            },
                            updateValueChanged: (value) {
                              AppSettingsService.instance
                                  .setNovelReaderFontSize(
                                value,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Text(
                        AppString.lineWidth,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NumberControllerWidget(
                            numText: (AppSettings.novelReaderLineSpacing.value)
                                .toStringAsFixed(1),
                            width: 100,
                            addValueChanged: (value) {
                              AppSettingsService.instance
                                  .setNovelReaderLineSpacing(
                                AppSettings.novelReaderLineSpacing.value + 0.1,
                              );
                            },
                            removeValueChanged: (value) {
                              AppSettingsService.instance
                                  .setNovelReaderLineSpacing(
                                AppSettings.novelReaderLineSpacing.value - 0.1,
                              );
                            },
                            updateValueChanged: (value) {
                              AppSettingsService.instance
                                  .setNovelReaderLineSpacing(
                                value,
                              );
                            },
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
                              AppSettingsService.instance.setScreenDirection(
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
                              AppSettingsService.instance.setScreenDirection(
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
