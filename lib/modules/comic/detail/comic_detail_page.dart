import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/chapter_type_enum.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/app/enums/show_type_enum.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/app/enums/sort_type_enum.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/dto/title_model.dart';
import 'package:liaz/models/recommend/recommend_item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/modules/comic/detail/comic_detail_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/widgets/toolbar/cross_list_widget.dart';
import 'package:liaz/widgets/toolbar/icon_item_widget.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';
import 'package:liaz/widgets/toolbar/three_box_grid_widget.dart';
import 'package:liaz/widgets/toolbar/title_widget.dart';
import 'package:liaz/widgets/toolbar/two_box_grid_widget.dart';
import 'package:remixicon/remixicon.dart';

class ComicDetailPage extends GetView<ComicDetailController> {
  const ComicDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 220),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: controller.detail.cover.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(
                          Global.appConfig.fileUrl + controller.detail.cover,
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
                    opacity: 0.1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AppBar(
              title: Text(
                controller.detail.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Remix.heart_3_line),
                ),
                IconButton(
                  onPressed: () {},
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
                        controller.detail.cover,
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
                                controller.detail.title,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconItemWidget(
                          iconData: Remix.user_line,
                          children: [
                            Text(
                              StrUtil.listToStr(
                                  controller.detail.authors, StrUtil.space),
                            ),
                          ],
                        ),
                        IconItemWidget(
                          iconData: Remix.price_tag_3_line,
                          children: [
                            Text(
                              StrUtil.listToStr(
                                  controller.detail.categories, StrUtil.space),
                            ),
                          ],
                        ),
                        IconItemWidget(
                          iconData: Remix.fire_line,
                          children: [
                            Text(
                              '${AppString.popularNum} ${controller.detail.hitNum}',
                            ),
                          ],
                        ),
                        IconItemWidget(
                          iconData: Remix.heart_3_line,
                          children: [
                            Text(
                              '${AppString.subscribeNum} ${controller.detail.subscribeNum}',
                            ),
                          ],
                        ),
                        IconItemWidget(
                          iconData: Remix.time_line,
                          children: [
                            Text(
                              '${DateUtil.formatDate(controller.detail.updated)} ${controller.detail.isSerializated ? AppString.serializated : AppString.finish}',
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppStyle.edgeInsetsH8,
          child: Column(
            children: [
              _buildDescription(context),
              _buildChapter(context),
              _buildRecommend(context),
            ],
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
            onTap: () {},
          ),
        ],
      ),
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
                  controller.isRelateRecommend.value = true;
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
                child: Text(
                  AppString.relateRecommend,
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  controller.isRelateRecommend.value = false;
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
                child: const Text(
                  AppString.startReading,
                  style: TextStyle(
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
        AppStyle.vGap12,
        Obx(
          () => Offstage(
            offstage: controller.isRelateRecommend.value,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.isExpandDescription.value =
                        !controller.isExpandDescription.value;
                  },
                  child: Text(
                    controller.detail.description,
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

  Widget _buildChapter(BuildContext context) {
    return Obx(
      () => Offstage(
        offstage: controller.isRelateRecommend.value,
        child: Column(
          children: (controller.detail.chapterTypes != null &&
                  controller.detail.chapterTypes!.isNotEmpty)
              ? controller.detail.chapterTypes!.map((item) {
                  var chapterType = item.chapterType;
                  var sortType = item.sortType;
                  var chapters = item.chapters;
                  String title = StrUtil.empty;
                  if (ChapterTypeEnum.serialize.index == chapterType) {
                    title =
                        '${AppString.serialize} （${AppString.total}${chapters.length}${AppString.chapter}）';
                  } else if (ChapterTypeEnum.extra.index == chapterType) {}
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                            ),
                          ),
                          sortType.value == SortTypeEnum.desc.index
                              ? TextButton.icon(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 14),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    sortType.value = SortTypeEnum.asc.index;
                                    item.sort();
                                  },
                                  icon: const Icon(
                                    Remix.sort_desc,
                                    size: 20,
                                  ),
                                  label: const Text(AppString.desc),
                                )
                              : TextButton.icon(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 14),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    sortType.value = SortTypeEnum.desc.index;
                                    item.sort();
                                  },
                                  icon: const Icon(
                                    Remix.sort_asc,
                                    size: 20,
                                  ),
                                  label: const Text(AppString.asc),
                                ),
                        ],
                      ),
                      LayoutBuilder(
                        builder: (ctx, constraints) {
                          var count = constraints.maxWidth ~/ 160;
                          if (count < 3) count = 3;
                          return Obx(
                            () => MasonryGridView.count(
                              crossAxisCount: count,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (item.isShowMoreButton &&
                                      !item.isShowAll.value)
                                  ? 15
                                  : item.chapters.length,
                              itemBuilder: (context, i) {
                                if (item.isShowMoreButton &&
                                    !item.isShowAll.value &&
                                    i == 14) {
                                  return Tooltip(
                                    message: AppString.expandAll,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor:
                                            i == 0 ? Colors.cyan : Colors.grey,
                                        backgroundColor: Colors.white,
                                        textStyle:
                                            const TextStyle(fontSize: 14),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        minimumSize: const Size.fromHeight(40),
                                        side: BorderSide(
                                          color: i == 0
                                              ? Colors.cyan
                                              : Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      onPressed: () {
                                        item.isShowAll.value = true;
                                      },
                                      child: const Icon(Icons.arrow_drop_down),
                                    ),
                                  );
                                }
                                return Tooltip(
                                  message: item.chapters[i].chapterName,
                                  child: Obx(
                                    () => OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor:
                                            i == 0 ? Colors.cyan : Colors.grey,
                                        backgroundColor: Colors.white,
                                        textStyle:
                                            const TextStyle(fontSize: 14),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        minimumSize: const Size.fromHeight(40),
                                        side: BorderSide(
                                          color: i == 0
                                              ? Colors.cyan
                                              : Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.onReadChapter(item.chapters[i]);
                                      },
                                      child: Text(
                                        item.chapters[i].chapterName,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }).toList()
              : [],
        ),
      ),
    );
  }

  Widget _buildRecommend(BuildContext context) {
    var list = [
      RecommendModel(
        recommendId: 1,
        title: '最近更新',
        showType: ShowTypeEnum.none.index,
        isShowTitle: true,
        optType: OptTypeEnum.none.index,
        items: [
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
        ],
      ),
      RecommendModel(
        recommendId: 3,
        title: '恋爱四格',
        showType: ShowTypeEnum.none.index,
        isShowTitle: true,
        optType: OptTypeEnum.none.index,
        items: [
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
        ],
      ),
      RecommendModel(
        recommendId: 2,
        title: '热门连载',
        showType: ShowTypeEnum.none.index,
        isShowTitle: true,
        optType: OptTypeEnum.none.index,
        items: [
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
        ],
      ),
    ];
    var childrens = <Widget>[];
    for (RecommendModel recommend in list) {
      var showType = recommend.showType;
      var title = TitleModel(
        titleId: recommend.recommendId,
        title: recommend.title,
        showType: recommend.showType,
        isShowTitle: recommend.isShowTitle,
        optType: recommend.optType,
        optValue: recommend.optValue,
      );
      var items = <ItemModel>[];
      for (var i = 0; i < recommend.items.length; i++) {
        var item = recommend.items[i];
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
      Widget widget;
      if (showType == ShowTypeEnum.twoGrid.index) {
        widget = TitleWidget(
          icon: Icons.chevron_right,
          color: Colors.grey,
          item: title,
          child: TwoBoxGridWidget(
            items: items,
            onTop: (item) =>
                AppNavigator.toComicDetail(ComicDetailModel.empty().toJson()),
          ),
        );
      } else if (showType == ShowTypeEnum.threeGrid.index) {
        widget = TitleWidget(
          icon: Icons.chevron_right,
          color: Colors.grey,
          item: title,
          child: ThreeBoxGridWidget(
            items: items,
            onTop: (item) =>
                AppNavigator.toComicDetail(ComicDetailModel.empty().toJson()),
          ),
        );
      } else {
        widget = TitleWidget(
          icon: Icons.chevron_right,
          color: Colors.grey,
          item: title,
          child: CrossListWidget(
            items: items,
            onTap: (item) =>
                AppNavigator.toComicDetail(ComicDetailModel.empty().toJson()),
          ),
        );
      }
      childrens.add(widget);
    }
    return Obx(() => Offstage(
          offstage: !controller.isRelateRecommend.value,
          child: Column(
            children: childrens,
          ),
        ));
  }
}
