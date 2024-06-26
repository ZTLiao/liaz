import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/ads_flag.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/tool_util.dart';
import 'package:liaz/modules/novel/reader/novel_horizontal_reader.dart';
import 'package:liaz/modules/novel/reader/novel_reader_controller.dart';
import 'package:liaz/services/advert_service.dart';
import 'package:liaz/widgets/status/app_error_widget.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';
import 'package:liaz/widgets/toolbar/local_image.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';

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
            resizeToAvoidBottomInset: true,
            backgroundColor:
                AppColor.novelThemes[AppSettings.novelReaderTheme.value]!.first,
            body: Stack(
              children: [
                Obx(
                  () => Offstage(
                    offstage: controller.content.value.isEmpty &&
                        !controller.isAllPicture.value,
                    child: GestureDetector(
                      onTap: () {
                        controller.setShowControls();
                      },
                      child: controller.isAllPicture.value
                          ? buildPicture()
                          : (controller.readDirection.value ==
                                  ReaderDirectionEnum.upToDown.index
                              ? buildVertical(context)
                              : buildHorizontal(context)),
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
                      color: AppStyle.darkTheme.cardColor.withOpacity(0.7),
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
                              controller.detail.value.chapterName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Visibility(
                            visible: !controller.isLocal.value,
                            child: Expanded(
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  const Text(
                                    AppString.detail,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.panorama_fish_eye,
                                    ),
                                    onPressed: controller.onDetail,
                                  ),
                                ],
                              ),
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
                      color: AppStyle.darkTheme.cardColor.withOpacity(0.7),
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
                              color:
                                  AppStyle.darkTheme.cardColor.withOpacity(0),
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
                                      onPressed: controller.showCatalogue,
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
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdvertService.instance
                    .buildBannerAdvert(context, AdsFlag.bottomBanner, 0, 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHorizontal(BuildContext context) {
    return EasyRefresh(
      header: const MaterialHeader(),
      footer: const MaterialFooter(),
      refreshOnStart: false,
      onRefresh: () async {
        controller.forwardChapter();
      },
      onLoad: () async {
        controller.nextChapter();
      },
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          ...controller.pictures.map(
            (url) => controller.detail.value.isLocal
                ? LocalImage(
                    url,
                    fit: BoxFit.contain,
                  )
                : NetImage(
                    url,
                    fit: BoxFit.fitWidth,
                    progress: true,
                  ),
          ),
          NovelHorizontalReader(
            controller.content.value,
            controller: controller.pageController,
            reverse: controller.readDirection.value ==
                ReaderDirectionEnum.rightToLeft.index,
            style: TextStyle(
              fontSize: AppSettings.novelReaderFontSize.value.toDouble(),
              height: AppSettings.novelReaderLineSpacing.value,
              color: AppColor
                  .novelThemes[AppSettings.novelReaderTheme.value]!.last,
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
        ],
      ),
    );
  }

  Widget buildVertical(BuildContext context) {
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
            header: const MaterialHeader(),
            footer: const DeliveryFooter(),
            refreshOnStart: false,
            onRefresh: () async {
              controller.forwardChapter();
            },
            onLoad: () async {
              controller.nextChapter();
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  ...controller.pictures.map(
                    (url) => controller.detail.value.isLocal
                        ? LocalImage(
                            url,
                            fit: BoxFit.contain,
                          )
                        : NetImage(
                            url,
                            fit: BoxFit.fitWidth,
                            progress: true,
                          ),
                  ),
                  Text(
                    controller.content.value,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize:
                          AppSettings.novelReaderFontSize.value.toDouble(),
                      height: AppSettings.novelReaderLineSpacing.value,
                      color: AppColor
                          .novelThemes[AppSettings.novelReaderTheme.value]!
                          .last,
                    ),
                  ),
                  AdvertService.instance
                      .buildBannerAdvert(context, AdsFlag.bottomBanner, 24, 5),
                ],
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
        header: const MaterialHeader(),
        footer: const MaterialFooter(),
        refreshOnStart: false,
        onRefresh: () async {
          controller.forwardChapter();
        },
        onLoad: () async {
          controller.nextChapter();
        },
        child: controller.readDirection.value !=
                ReaderDirectionEnum.upToDown.index
            ? PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pictures.length,
                reverse: controller.readDirection.value ==
                    ReaderDirectionEnum.rightToLeft.index,
                onPageChanged: (e) {
                  controller.currentIndex.value = e;
                  controller.maxPage.value = controller.pictures.length;
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          (AppSettings.novelReaderShowStatus.value ? 24 : 12),
                    ),
                    child: GestureDetector(
                      onDoubleTap: () {
                        ToolUtil.showImageViewer(
                            i, controller.pictures.toList());
                      },
                      child: controller.detail.value.isLocal
                          ? LocalImage(
                              controller.pictures[i],
                              fit: BoxFit.contain,
                            )
                          : NetImage(
                              controller.pictures[i],
                              fit: BoxFit.contain,
                              progress: true,
                            ),
                    ),
                  );
                })
            : ListView.separated(
                controller: controller.scrollController,
                itemCount: controller.pictures.length,
                padding: EdgeInsets.zero,
                separatorBuilder: (_, i) => AppStyle.vGap4,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onDoubleTap: () {
                      ToolUtil.showImageViewer(i, controller.pictures.toList());
                    },
                    child: controller.detail.value.isLocal
                        ? LocalImage(
                            controller.pictures[i],
                            fit: BoxFit.fitWidth,
                          )
                        : NetImage(
                            controller.pictures[i],
                            fit: BoxFit.fitWidth,
                            progress: true,
                          ),
                  );
                },
              ),
      ),
    );
  }

  Widget buildSilderBar() {
    if (controller.readDirection.value == ReaderDirectionEnum.upToDown.index) {
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
        var max = controller.maxPage.value.toDouble();
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
                  controller.readDirection.value !=
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
