import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/comic/detail/comic_detail_controller.dart';
import 'package:liaz/widgets/toolbar/icon_item_widget.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';
import 'package:remixicon/remixicon.dart';

class ComicDetailPage extends GetView<ComicDetailController> {
  ComicDetailPage({super.key});

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
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width / 5, 40)),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      child: Text(
                        "相关推荐",
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 5, 40),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        "开始阅读",
                      ),
                    ),
                  ),
                ],
              ),
              AppStyle.vGap12,
              Obx(
                () => GestureDetector(
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
              ),
              AppStyle.vGap12,
              Divider(
                color: Colors.grey.withOpacity(.2),
                height: 1.0,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        overlayColor: Colors.black,
        overlayOpacity: 0,
        icon: Icons.rocket,
        elevation: 4.0,
        buttonSize: Size(50, 50),
        childrenButtonSize: Size(50, 50),
        //animationAngle: -3.14 / 4,
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
}
