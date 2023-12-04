import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/app/enums/show_type_enum.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
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
                image: DecorationImage(
                  image: NetworkImage(
                    'https://cdn.aqdstatic.com:966/age/20230207.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
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
              title: const Text(
                '葬送的芙莉莲',
                style: TextStyle(
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
                        "https://cdn.aqdstatic.com:966/age/20230207.jpg",
                        width: 120,
                        height: 160,
                        borderRadius: 4,
                      ),
                    ],
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconItemWidget(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                '葬送的芙莉莲',
                                maxLines: 1,
                                style: TextStyle(
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
                              '山田鐘人 アベツカサ',
                            ),
                          ],
                        ),
                        IconItemWidget(
                          iconData: Remix.price_tag_3_line,
                          children: [
                            Text(
                              '冒险 奇幻',
                            ),
                          ],
                        ),
                        IconItemWidget(
                          iconData: Remix.fire_line,
                          children: [
                            Text(
                              '人气 1000000',
                            ),
                          ],
                        ),
                        IconItemWidget(
                          iconData: Remix.heart_3_line,
                          children: [
                            Text(
                              '订阅 1000000',
                            ),
                          ],
                        ),
                        IconItemWidget(
                          iconData: Remix.time_line,
                          children: [
                            Text(
                              '2023-12-02 19:00 连载中',
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
                child: Text(
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
                    '''
魔法使芙莉莲与勇者辛美尔等人在长达10年的冒险中打败了魔王，给世界带来了和平。
作为一个活了一千多年的精灵，芙莉莲约定将与辛美尔等人再会，自己则先独自旅行。
五十年后，芙莉莲拜访了辛美尔，但辛美尔已经老了，生命已所剩无几。
之后，芙莉莲目睹了辛美尔的死亡，她也猛地意识到自己从未“了解人类”，并后悔不已，因此她踏上了“为了了解人类”的旅途。在那段旅途中，她邂逅了各种各样的人，经历了各种各样的事。
''',
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
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '连载（共100话）',
                  ),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Remix.sort_asc,
                    size: 20,
                  ),
                  label: const Text('升序'),
                ),
              ],
            ),
            LayoutBuilder(
              builder: (ctx, constraints) {
                var count = constraints.maxWidth ~/ 160;
                if (count < 3) count = 3;
                return MasonryGridView.count(
                  crossAxisCount: count,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (context, i) {
                    return Tooltip(
                      message: "展开全部章节",
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: i == 0 ? Colors.cyan : Colors.grey,
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 14),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size.fromHeight(40),
                          side: BorderSide(
                            color: i == 0
                                ? Colors.cyan
                                : Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        onPressed: () {},
                        child: Text('第 ${i + 1} 话'),
                      ),
                    );
                  },
                );
              },
            ),
          ],
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
        showTitle: YesOrNo.yes,
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
        showTitle: YesOrNo.yes,
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
        showTitle: YesOrNo.yes,
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
        showTitle: recommend.showTitle,
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
            onTop: (item) => AppNavigator.toComicDetail(1),
          ),
        );
      } else if (showType == ShowTypeEnum.threeGrid.index) {
        widget = TitleWidget(
          icon: Icons.chevron_right,
          color: Colors.grey,
          item: title,
          child: ThreeBoxGridWidget(
            items: items,
            onTop: (item) => AppNavigator.toComicDetail(1),
          ),
        );
      } else {
        widget = TitleWidget(
          icon: Icons.chevron_right,
          color: Colors.grey,
          item: title,
          child: CrossListWidget(
            items: items,
            onTop: (item) => AppNavigator.toComicDetail(1),
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
