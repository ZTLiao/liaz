import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/tool_util.dart';
import 'package:liaz/modules/novel/reader/novel_horizontal_reader.dart';
import 'package:liaz/modules/novel/reader/novel_reader_controller.dart';
import 'package:liaz/widgets/status/app_error_widget.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';
import 'package:liaz/widgets/toolbar/local_image.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';
import 'package:liaz/widgets/view/custom_material.dart';

class NovelReaderPage extends GetView<NovelReaderController> {
  const NovelReaderPage({super.key});

  Color get color =>
      AppColor.novelThemes[AppSettings.novelReaderTheme.value]!.last;

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      onKey: (e) {
        if (e.runtimeType == RawKeyUpEvent) {
          controller.keyDown(e.logicalKey);
          Log.i(e.toString());
        }
      },
      focusNode: controller.focusNode,
      autofocus: true,
      child: Theme(
        data: AppStyle.darkTheme,
        child: Obx(
          () => Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor:
                AppColor.novelThemes[AppSettings.novelReaderTheme.value]!.first,
            body: Stack(
              children: [
                Obx(
                  () => Offstage(
                    offstage: false,
                    child: GestureDetector(
                      onTap: () {
                        controller.setShowControls();
                      },
                      //TODO
                      child: false
                          ? buildPicture()
                          : (controller.direction.value ==
                                  ReaderDirectionEnum.upToDown.index
                              ? buildVertical()
                              : buildHorizontal()),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            controller.leftHandMode
                                ? controller.nextPage()
                                : controller.forwardPage();
                          },
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            controller.leftHandMode
                                ? controller.forwardPage()
                                : controller.nextPage();
                          },
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Offstage(
                    offstage: !controller.isPageLoading.value,
                    child: const AppLoadingWidget(),
                  ),
                ),
                Obx(
                  () => Offstage(
                    offstage: !controller.isPageError.value,
                    child: AppErrorWidget(
                      errorMsg: controller.errorMsg.value,
                      onRefresh: () => controller.loadContent(),
                    ),
                  ),
                ),
                buildBottomStatus(),
                //顶部
                Obx(
                  () => AnimatedPositioned(
                    top: controller.showControls.value
                        ? 0
                        : -(48 + AppStyle.statusBarHeight),
                    left: 0,
                    right: 0,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      color: AppStyle.darkTheme.cardColor,
                      height: 48 + AppStyle.statusBarHeight,
                      padding: EdgeInsets.only(top: AppStyle.statusBarHeight),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: Get.back,
                            icon: const Icon(Icons.arrow_back),
                          ),
                          AppStyle.hGap12,
                          Expanded(
                            child: Text(
                              controller.chapters[controller.chapterIndex.value]
                                  .chapterName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //底部
                Obx(
                  () => AnimatedPositioned(
                    bottom: controller.showControls.value
                        ? 0
                        : -(104 + AppStyle.bottomBarHeight),
                    left: 0,
                    right: 0,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      color: AppStyle.darkTheme.cardColor,
                      height: 104 + AppStyle.bottomBarHeight,
                      padding:
                          EdgeInsets.only(bottom: AppStyle.bottomBarHeight),
                      alignment: Alignment.center,
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 500,
                        ),
                        child: Column(
                          children: [
                            buildSilderBar(),
                            Material(
                              color: AppStyle.darkTheme.cardColor,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: controller.forwardChapter,
                                      icon: const Icon(
                                        Icons.skip_previous,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: controller.showMenu,
                                      icon: const Icon(
                                        Icons.list,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: controller.showSettings,
                                      icon: const Icon(
                                        Icons.settings,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: controller.nextChapter,
                                      icon: const Icon(
                                        Icons.skip_next,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHorizontal() {
    return EasyRefresh(
      header: CustomMaterialHeader(
        triggerOffset: 80,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppStyle.radius24,
          ),
          padding: AppStyle.edgeInsetsA12,
          child: const Icon(
            Icons.arrow_circle_left,
            color: Colors.blue,
          ),
        ),
      ),
      footer: CustomMaterialFooter(
        triggerOffset: 80,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppStyle.radius24,
          ),
          padding: AppStyle.edgeInsetsA12,
          child: const Icon(
            Icons.arrow_circle_right,
            color: Colors.blue,
          ),
        ),
      ),
      refreshOnStart: false,
      onRefresh: () async {
        controller.forwardChapter();
      },
      onLoad: () async {
        controller.nextChapter();
      },
      child: NovelHorizontalReader(
        controller.content.value,
        controller: controller.pageController,
        reverse:
            controller.direction.value == ReaderDirectionEnum.rightToLeft.index,
        style: TextStyle(
          fontSize: AppSettings.novelReaderFontSize.value.toDouble(),
          height: AppSettings.novelReaderLineSpacing.value,
          color: AppColor.novelThemes[AppSettings.novelReaderTheme.value]!.last,
        ),
        padding: AppStyle.edgeInsetsA12.copyWith(
          top: AppStyle.statusBarHeight + 12,
          bottom: (AppSettings.novelReaderShowStatus.value ? 24 : 12),
        ),
        onPageChanged: (i, m) {
          controller.currentIndex.value = i;
          controller.maxPage.value = m;
        },
      ),
    );
  }

  Widget buildVertical() {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppStyle.statusBarHeight,
        ),
        child: Padding(
          padding: AppStyle.edgeInsetsA12.copyWith(
            bottom: (AppSettings.novelReaderShowStatus.value ? 32 : 12),
          ),
          child: EasyRefresh(
            header: CustomMaterialHeader(
              triggerOffset: 80,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppStyle.radius24,
                ),
                padding: AppStyle.edgeInsetsA12,
                child: const Icon(
                  Icons.arrow_circle_up,
                  color: Colors.cyan,
                ),
              ),
            ),
            footer: CustomMaterialFooter(
              triggerOffset: 80,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppStyle.radius24,
                ),
                padding: AppStyle.edgeInsetsA12,
                child: const Icon(
                  Icons.arrow_circle_down,
                  color: Colors.cyan,
                ),
              ),
            ),
            refreshOnStart: false,
            onRefresh: () async {
              controller.forwardChapter();
            },
            onLoad: () async {
              controller.nextChapter();
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Text(
                controller.content.value,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: AppSettings.novelReaderFontSize.value.toDouble(),
                  height: AppSettings.novelReaderLineSpacing.value,
                  color: AppColor
                      .novelThemes[AppSettings.novelReaderTheme.value]!.last,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPicture() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppStyle.statusBarHeight,
      ),
      child: EasyRefresh(
        header: CustomMaterialHeader(
          triggerOffset: 80,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppStyle.radius24,
            ),
            padding: AppStyle.edgeInsetsA12,
            child: Icon(
              controller.direction.value != ReaderDirectionEnum.upToDown.index
                  ? Icons.arrow_circle_left
                  : Icons.arrow_circle_up,
              color: Colors.cyan,
            ),
          ),
        ),
        footer: CustomMaterialFooter(
          triggerOffset: 80,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppStyle.radius24,
            ),
            padding: AppStyle.edgeInsetsA12,
            child: Icon(
              controller.direction.value != ReaderDirectionEnum.upToDown.index
                  ? Icons.arrow_circle_right
                  : Icons.arrow_circle_down,
              color: Colors.cyan,
            ),
          ),
        ),
        refreshOnStart: false,
        onRefresh: () async {
          controller.forwardChapter();
        },
        onLoad: () async {
          controller.nextChapter();
        },
        child: controller.direction.value != ReaderDirectionEnum.upToDown.index
            ? PageView.builder(
                controller: controller.pageController,
                //TODO picture
                itemCount: 10,
                reverse: controller.direction.value ==
                    ReaderDirectionEnum.rightToLeft.index,
                onPageChanged: (e) {
                  controller.currentIndex.value = e;
                  controller.maxPage.value = 10;
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          (AppSettings.novelReaderShowStatus.value ? 24 : 12),
                    ),
                    child: GestureDetector(
                      onDoubleTap: () {},
                      child: NetImage(
                        '',
                        fit: BoxFit.contain,
                        progress: true,
                      ),
                    ),
                  );
                })
            : ListView.separated(
                controller: controller.scrollController,
                itemCount: 10,
                padding: EdgeInsets.zero,
                separatorBuilder: (_, i) => AppStyle.vGap4,
                itemBuilder: (_, i) {
                  //TODO
                  return GestureDetector(
                    onDoubleTap: () {
                      ToolUtil.showImageViewer(i, []);
                    },
                    child: false
                        ? LocalImage(
                            '',
                            fit: BoxFit.fitWidth,
                          )
                        : NetImage(
                            '',
                            fit: BoxFit.fitWidth,
                            progress: true,
                          ),
                  );
                }),
      ),
    );
  }

  Widget buildSilderBar() {
    if (controller.direction.value == ReaderDirectionEnum.upToDown.index) {
      return Obx(
        () {
          var value = controller.progress.value;
          var max = 1.0;
          if (value > max) {
            return const SizedBox(
              height: 48,
            );
          }
          return SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: Slider(
                    value: value,
                    max: max,
                    onChanged: (e) {
                      controller.scrollController.jumpTo(
                        controller.scrollController.position.maxScrollExtent *
                            e,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return Obx(
      () {
        var value = controller.currentIndex.value + 1.0;
        var max = controller.maxPage.value;
        if (value > max) {
          return const SizedBox(
            height: 48,
          );
        }
        return SizedBox(
          height: 48,
          child: Row(
            children: [
              Expanded(
                child: Slider(
                  value: value,
                  max: max.toDouble(),
                  onChanged: (e) {
                    controller.jumpToPage((e - 1).toInt());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildBottomStatus() {
    return Positioned(
      right: 8,
      left: 8,
      bottom: 4,
      child: Obx(
        () => Offstage(
          offstage: !AppSettings.novelReaderShowStatus.value,
          child: Container(
            padding: AppStyle.edgeInsetsA12.copyWith(top: 4, bottom: 4),
            child: Obx(
              () => Row(
                children: [
                  buildConnectivity(),
                  buildBattery(),
                  const Expanded(child: SizedBox()),
                  controller.direction.value !=
                          ReaderDirectionEnum.upToDown.index
                      ? Text(
                          '${controller.detail.value.paths.isEmpty ? 0 : controller.currentIndex.value + 1} / ${controller.maxPage.value}',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.0,
                            color: color.withOpacity(.6),
                          ),
                        )
                      : Text(
                          '${(controller.progress.value * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.0,
                            color: color.withOpacity(.6),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildConnectivity() {
    var connectivityType = controller.connectivityType.value;
    IconData icon = Icons.wifi;
    var name = AppString.wifi;
    switch (connectivityType) {
      case ConnectivityResult.bluetooth:
        icon = Icons.bluetooth;
        name = AppString.bluetooth;
        break;
      case ConnectivityResult.ethernet:
        icon = Icons.settings_ethernet;
        name = AppString.computer;
        break;
      case ConnectivityResult.mobile:
        icon = Icons.smartphone;
        name = AppString.baseStation;
        break;
      case ConnectivityResult.wifi:
        icon = Icons.wifi;
        name = AppString.wifi;
        break;
      case ConnectivityResult.vpn:
        icon = Icons.vpn_key;
        name = AppString.vpn;
        break;
      case ConnectivityResult.none:
        icon = Icons.wifi_off;
        name = AppString.wifiOff;
        break;
      case ConnectivityResult.other:
        icon = Icons.question_mark;
        name = AppString.unkown;
        break;
      default:
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 12,
        ),
        AppStyle.hGap4,
        Text(
          name,
          style: const TextStyle(fontSize: 12, height: 1.0),
        ),
        AppStyle.hGap8,
      ],
    );
  }

  Widget buildBattery() {
    var battery = controller.batteryLevel.value;
    return Visibility(
      visible: controller.showBattery.value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${AppString.battery} $battery%',
            style: const TextStyle(fontSize: 12, height: 1.0),
          ),
          AppStyle.hGap8,
        ],
      ),
    );
  }
}
