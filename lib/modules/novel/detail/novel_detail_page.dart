import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/ads_flag.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/app/enums/show_type_enum.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/dto/title_model.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/modules/novel/detail/novel_detail_controller.dart';
import 'package:liaz/services/advert_service.dart';
import 'package:liaz/services/recommend_service.dart';
import 'package:liaz/widgets/toolbar/cross_list_widget.dart';
import 'package:liaz/widgets/toolbar/icon_item_widget.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';
import 'package:liaz/widgets/toolbar/three_box_grid_widget.dart';
import 'package:liaz/widgets/toolbar/title_widget.dart';
import 'package:liaz/widgets/toolbar/two_box_grid_widget.dart';

class NovelDetailPage extends StatelessWidget {
  final NovelDetailModel novelDetail;
  final NovelDetailController controller;

  NovelDetailPage(this.novelDetail, {super.key})
      : controller = Get.put(
          NovelDetailController(
            novelDetail: novelDetail,
          ),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 220),
          child: _buildHeader(context),
        ),
        body: Offstage(
          offstage: controller.detail.value.novelId == 0,
          child: SingleChildScrollView(
            child: Padding(
              padding: AppStyle.edgeInsetsH8,
              child: Column(
                children: [
                  _buildDescription(context),
                  _buildChapter(),
                  _buildRecommend(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          overlayColor: Colors.black,
          overlayOpacity: 0,
          icon: Icons.rocket,
          elevation: 4.0,
          buttonSize: const Size(50, 50),
          childrenButtonSize: const Size(50, 50),
          activeIcon: Icons.rocket_launch,
          direction: SpeedDialDirection.up,
          spaceBetweenChildren: 4.0,
          spacing: 4.0,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.download),
              backgroundColor: Colors.blue[300],
              foregroundColor: Colors.white,
              onTap: controller.onDownload,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: controller.detail.value.cover.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(
                      controller.detail.value.cover,
                    ),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        Center(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        Get.isDarkMode ? Colors.black45 : Colors.grey.shade50,
                  ),
                ),
              ),
            ),
          ),
        ),
        AppBar(
          title: Text(
            controller.detail.value.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: controller.subscribe,
              icon: Obx(
                () => Icon(
                  Icons.favorite,
                  color: controller.isSubscribe.value ? Colors.red : null,
                ),
              ),
            ),
            IconButton(
              onPressed: controller.share,
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        Container(
          padding: AppStyle.edgeInsetsA8,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NetImage(
                    controller.detail.value.cover,
                    width: 120,
                    height: 160,
                    borderRadius: 4,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconItemWidget(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            controller.detail.value.title,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconItemWidget(
                      iconData: Icons.person,
                      children: [
                        Text(
                          StrUtil.listToStr(
                              controller.detail.value.authors, StrUtil.space),
                        ),
                      ],
                    ),
                    IconItemWidget(
                      iconData: Icons.label,
                      children: [
                        Text(
                          StrUtil.listToStr(controller.detail.value.categories,
                              StrUtil.space),
                        ),
                      ],
                    ),
                    IconItemWidget(
                      iconData: Icons.local_fire_department,
                      children: [
                        Text(
                          '${AppString.popularNum} ${controller.detail.value.hitNum}',
                        ),
                      ],
                    ),
                    IconItemWidget(
                      iconData: Icons.favorite,
                      children: [
                        Text(
                          '${AppString.subscribeNum} ${controller.detail.value.subscribeNum}',
                        ),
                      ],
                    ),
                    IconItemWidget(
                      iconData: Icons.schedule,
                      children: [
                        Text(
                          '${DateUtil.formatDate(controller.detail.value.updated)} ${controller.detail.value.isSerializated ? AppString.serializated : AppString.finish}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  controller.isRelateRecommend.value =
                      !controller.isRelateRecommend.value;
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width / 5, 40)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return Get.isDarkMode ? Colors.blue : Colors.white;
                    },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.cyan;
                    }
                    return Get.isDarkMode ? Colors.black : Colors.white;
                  }),
                ),
                child: Obx(
                  () => Text(
                    AppString.relateRecommend,
                    style: TextStyle(
                      color: controller.isRelateRecommend.value
                          ? Colors.cyan
                          : (Get.isDarkMode ? Colors.white : Colors.black54),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: controller.startReading,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width / 5, 40)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return Get.isDarkMode ? Colors.black : Colors.white;
                    },
                  ),
                  //背景颜色
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.cyan;
                    }
                    return Get.isDarkMode ? Colors.black : Colors.white;
                  }),
                ),
                child: Text(
                  controller.browseChapterId.value != 0
                      ? AppString.continueReading
                      : AppString.startReading,
                  style: const TextStyle(
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey.withOpacity(.2),
          height: 1.0,
        ),
        AdvertService.instance
            .buildBannerAdvert(context, AdsFlag.detailBanner, 8, 10),
        AppStyle.vGap12,
        Obx(
          () => Visibility(
            visible: !controller.isRelateRecommend.value,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.isExpandDescription.value =
                        !controller.isExpandDescription.value;
                  },
                  child: Text(
                    controller.detail.value.description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    maxLines: controller.isExpandDescription.value ? 999 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                controller.isExpandDescription.value
                    ? const SizedBox()
                    : AppStyle.vGap12,
                Divider(
                  color: Colors.grey.withOpacity(.2),
                  height: 1.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChapter() {
    var volumes = controller.detail.value.volumes;
    return Obx(
      () => Visibility(
        visible: !controller.isRelateRecommend.value,
        child: Column(
          children: [
            ...volumes.map(
              (volume) => Column(
                children: [
                  ExpansionTile(
                    initiallyExpanded: volumes.length == 1,
                    title: Text(
                      '${(volume.volumeName != null && volume.volumeName!.isNotEmpty) ? volume.volumeName : AppString.serialize} （${AppString.total}${volume.chapters.length}${AppString.novelVolume}）',
                    ),
                    tilePadding: AppStyle.edgeInsetsH4,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (!volume.isShowAll.value)
                            ? (volume.pageSize.value > volume.chapters.length)
                                ? volume.chapters.length
                                : volume.pageSize.value
                            : volume.chapters.length,
                        itemBuilder: (context, i) {
                          var item = volume.chapters[i];
                          if (!volume.isShowAll.value &&
                              i == (volume.pageSize.value - 1)) {
                            return ListTile(
                              title: const Column(
                                children: [
                                  Center(
                                    child: Text(AppString.loadingMore),
                                  ),
                                ],
                              ),
                              contentPadding: AppStyle.edgeInsetsA4,
                              visualDensity: const VisualDensity(
                                vertical: VisualDensity.minimumDensity,
                              ),
                              onTap: () {
                                volume.pageSize.value += 15;
                              },
                            );
                          }
                          return ListTile(
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Obx(
                                          () => Container(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                            ),
                                            child: Text(
                                              item.chapterName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Get.textTheme.bodyMedium!
                                                  .copyWith(
                                                color: item.novelChapterId ==
                                                        controller
                                                            .browseChapterId
                                                            .value
                                                    ? Colors.cyan
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${AppString.at} ${DateUtil.formatDateTimeMinute(item.updatedAt)} ${AppString.publish}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColor.grey99,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              controller.onPreview(i, volume);
                                            },
                                            icon: const Icon(
                                              Icons.info_outline,
                                              color: AppColor.grey99,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        (controller.isExpandPreview.value &&
                                            controller.chapterIndex.value == i),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColor
                                            .novelThemes[AppSettings
                                                .novelReaderTheme.value]!
                                            .first,
                                      ),
                                      child: Text(
                                        controller.content.value,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppColor.grey99,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            contentPadding: AppStyle.edgeInsetsA4,
                            visualDensity: const VisualDensity(
                              vertical: VisualDensity.minimumDensity,
                            ),
                            onTap: () {
                              controller.chapterIndex.value = i;
                              controller.onReadChapter(volume);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(.2),
                    height: 1.0,
                  ),
                ],
              ),
            ),
            AppStyle.vGap60,
          ],
        ),
      ),
    );
  }

  Widget _buildRecommend() {
    return Obx(
      () => Visibility(
        visible: controller.isRelateRecommend.value,
        child: Column(
          children: controller.recommends.map((element) {
            var showType = element.showType;
            var title = TitleModel(
              titleId: element.recommendId,
              title: element.title,
              showType: element.showType,
              isShowTitle: element.isShowTitle,
              optType: element.optType,
              optValue: element.optValue,
            );
            var items = <ItemModel>[];
            for (var i = 0; i < element.items.length; i++) {
              var item = element.items[i];
              items.add(ItemModel(
                itemId: item.recommendItemId,
                title: item.title,
                subTitle: item.subTitle,
                showValue: item.showValue,
                skipType: item.skipType,
                skipValue: item.skipValue,
                objId: item.objId,
              ));
            }
            if (items.isEmpty) {
              return const SizedBox();
            }
            IconData? icon;
            if (element.optType == OptTypeEnum.refresh.index) {
              icon = Icons.refresh;
            } else if (element.optType == OptTypeEnum.more.index) {
              icon = Icons.read_more;
            } else if (element.optType == OptTypeEnum.jump.index) {
              icon = Icons.chevron_right;
            }
            Widget widget;
            if (showType == ShowTypeEnum.twoGrid.index) {
              widget = TitleWidget(
                icon: icon,
                color: Colors.grey,
                item: title,
                child: TwoBoxGridWidget(
                  items: items,
                  onTap: RecommendService.instance.onDetail,
                ),
              );
            } else if (showType == ShowTypeEnum.threeGrid.index) {
              widget = TitleWidget(
                icon: icon,
                color: Colors.grey,
                item: title,
                child: ThreeBoxGridWidget(
                  items: items,
                  onTap: RecommendService.instance.onDetail,
                ),
              );
            } else {
              widget = TitleWidget(
                icon: icon,
                color: Colors.grey,
                item: title,
                child: CrossListWidget(
                  items: items,
                  onTap: RecommendService.instance.onDetail,
                ),
              );
            }
            return widget;
          }).toList(),
        ),
      ),
    );
  }
}
