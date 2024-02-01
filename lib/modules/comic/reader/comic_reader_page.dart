import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/modules/comic/reader/comic_reader_controller.dart';
import 'package:liaz/widgets/status/app_error_widget.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';
import 'package:liaz/widgets/toolbar/local_image.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ComicReaderPage extends GetView<ComicReaderController> {
  const ComicReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      onKey: (e) {
        if (e.runtimeType == RawKeyUpEvent) {
          controller.keyDown(e.logicalKey);
          Log.d(e.toString());
        }
      },
      focusNode: controller.focusNode,
      autofocus: true,
      child: Theme(
        data: AppStyle.darkTheme,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Obx(
                () => Offstage(
                  offstage: controller.detail.value.comicChapterId == 0,
                  child: GestureDetector(
                    onTap: () {
                      controller.setShowControls();
                    },
                    child: controller.readDirection.value ==
                            ReaderDirectionEnum.upToDown.index
                        ? buildVertical()
                        : buildHorizontal(),
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
                    onRefresh: () => controller.loadDetail(),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Obx(
                  () => Offstage(
                    offstage: !AppSettings.comicReaderShowStatus.value,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      padding:
                          AppStyle.edgeInsetsA12.copyWith(top: 4, bottom: 4),
                      child: Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildConnectivity(),
                            buildBattery(),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 100),
                              child: Text(
                                controller.detail.value.chapterName,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    const TextStyle(fontSize: 12, height: 1.0),
                              ),
                            ),
                            AppStyle.hGap8,
                            Text(
                              "${controller.detail.value.paths.isEmpty ? 0 : controller.currentIndex.value + 1} / ${controller.detail.value.paths.length}",
                              style: const TextStyle(fontSize: 12, height: 1.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
                          child: Obx(
                            () => Text(
                              controller.detail.value.chapterName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                    padding: EdgeInsets.only(bottom: AppStyle.bottomBarHeight),
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      child: Column(
                        children: [
                          buildSilderBar(),
                          Material(
                            color: AppStyle.darkTheme.cardColor.withOpacity(0),
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
        ),
      ),
    );
  }

  Widget buildHorizontal() {
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
      child: PreloadPageView.builder(
        controller: controller.preloadPageController,
        onPageChanged: (e) {
          controller.currentIndex.value = e;
        },
        reverse: controller.readDirection.value ==
            ReaderDirectionEnum.rightToLeft.index,
        physics: controller.lockSwipe.value
            ? const NeverScrollableScrollPhysics()
            : null,
        itemCount: controller.detail.value.paths.length,
        preloadPagesCount: 4,
        itemBuilder: (_, i) {
          var url = controller.detail.value.paths[i];
          return PhotoView.customChild(
            wantKeepAlive: true,
            initialScale: 1.0,
            onScaleEnd: (context, detail, e) {
              controller.lockSwipe.value = (e.scale ?? 1) > 1.0;
            },
            child: controller.detail.value.isLocal
                ? LocalImage(
                    url,
                    fit: BoxFit.contain,
                  )
                : NetImage(
                    url,
                    fit: BoxFit.contain,
                    progress: true,
                  ),
          );
        },
      ),
    );
  }

  Widget buildVertical() {
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
      child: Obx(
        () => ScrollablePositionedList.builder(
          itemScrollController: controller.itemScrollController,
          itemCount: controller.detail.value.paths.length,
          itemPositionsListener: controller.itemPositionsListener,
          itemBuilder: (_, i) {
            var url = controller.detail.value.paths[i];
            return Container(
              constraints: const BoxConstraints(
                minHeight: 200,
              ),
              child: controller.detail.value.isLocal
                  ? LocalImage(
                      url,
                      fit: BoxFit.contain,
                    )
                  : NetImage(
                      url,
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
    return Obx(
      () {
        var value = controller.currentIndex.value + 1.0;
        var max = controller.detail.value.paths.length.toDouble();
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
                    controller.jumpToPage((e - 2).toInt());
                  },
                ),
              ),
            ],
          ),
        );
      },
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
