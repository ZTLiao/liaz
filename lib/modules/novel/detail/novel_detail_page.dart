import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/app/enums/show_type_enum.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/dto/title_model.dart';
import 'package:liaz/models/recommend/recommend_item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/modules/novel/detail/novel_detail_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/widgets/toolbar/cross_list_widget.dart';
import 'package:liaz/widgets/toolbar/icon_item_widget.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';
import 'package:liaz/widgets/toolbar/three_box_grid_widget.dart';
import 'package:liaz/widgets/toolbar/title_widget.dart';
import 'package:liaz/widgets/toolbar/two_box_grid_widget.dart';
import 'package:remixicon/remixicon.dart';

class NovelDetailPage extends GetView<NovelDetailController> {
  const NovelDetailPage({super.key});

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
                    'https://www.miaocyacg.com/upload/20230423/9a3507b54cde75ea491eb54f4a9a5ec3.jpg',
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
                '因为不是真正的伙伴而被逐出勇者队伍，流落到边境展开慢活人生',
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
                        "https://www.miaocyacg.com/upload/20230423/9a3507b54cde75ea491eb54f4a9a5ec3.jpg",
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
                                '因为不是真正的伙伴而被逐出勇者队伍，流落到边境展开慢活人生',
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
                              'ざっぽん',
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
                              '2023-04-30 18:58 连载中',
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
“你不是真正的伙伴──”
英雄雷德跟不上最前线的战斗，
遭到队友贤者屏除在战力之外，被踢出了勇者队伍。
“唉，那时候真够难受的啊。”
雷德离开一事在贤者等人之间引发轩然大波，
但他本人毫不知情，不仅搬到边境地区居住，
还准备开一间药草店，就这样抱着兴奋期待的心情过日子……
“我可以在这间店工作吗？顺便让我借住在这里！”
身为昔日伙伴的公主忽然找上门来!?
★一起过着快乐惬意的生活吧！
★被踢出队伍的英雄，与公主一起度过幸福美满的甜蜜生活！没有得到回报的英雄将展开美好的第二人生！  
——
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
            ExpansionTile(
              title: Text(
                '第一章（共20卷）',
              ),
              tilePadding: AppStyle.edgeInsetsH4,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (_, i) => const Divider(
                    height: 1,
                  ),
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(
                        '第 $i 章',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: i == 0 ? Colors.cyan : null,
                        ),
                      ),
                      contentPadding: AppStyle.edgeInsetsA4,
                      visualDensity: const VisualDensity(
                          vertical: VisualDensity.minimumDensity),
                      onTap: () {},
                    );
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.grey.withOpacity(.2),
              height: 1.0,
            ),
            ExpansionTile(
              title: Text(
                '第二章（共9卷）',
              ),
              tilePadding: AppStyle.edgeInsetsH4,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (_, i) => const Divider(
                    height: 1,
                  ),
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(
                        '第 $i 章',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: i == 0 ? Colors.cyan : null,
                        ),
                      ),
                      contentPadding: AppStyle.edgeInsetsA4,
                      visualDensity: const VisualDensity(
                          vertical: VisualDensity.minimumDensity),
                      onTap: () {},
                    );
                  },
                ),
              ],
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
            onTop: (item) => AppNavigator.toComicDetail(ComicDetailModel.empty().toJson()),
          ),
        );
      } else if (showType == ShowTypeEnum.threeGrid.index) {
        widget = TitleWidget(
          icon: Icons.chevron_right,
          color: Colors.grey,
          item: title,
          child: ThreeBoxGridWidget(
            items: items,
            onTop: (item) => AppNavigator.toComicDetail(ComicDetailModel.empty().toJson()),
          ),
        );
      } else {
        widget = TitleWidget(
          icon: Icons.chevron_right,
          color: Colors.grey,
          item: title,
          child: CrossListWidget(
            items: items,
            onTap: (item) => AppNavigator.toComicDetail(ComicDetailModel.empty().toJson()),
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
