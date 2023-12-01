import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/comic/detail/comic_detail_controller.dart';
import 'package:liaz/widgets/status/app_error_widget.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';
import 'package:remixicon/remixicon.dart';

class ComicDetailPage extends GetView<ComicDetailController> {
  ComicDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("漫画详情"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Remix.star_line),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: false,
            child: EasyRefresh(
              header: const MaterialHeader(),
              onRefresh: () {},
              child: ListView(
                padding: AppStyle.edgeInsetsA12,
                children: [
                  _buildHeader(),
                  Offstage(
                    offstage: false,
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "上次看到： 第10页",
                            style: Get.textTheme.titleSmall,
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(.2),
                          height: 1.0,
                        ),
                      ],
                    ),
                  ),
                  _buildChapter(),
                ],
              ),
            ),
          ),
          Offstage(
            offstage: true,
            child: const AppLoadingWidget(),
          ),
          Offstage(
            offstage: true,
            child: AppErrorWidget(
              errorMsg: controller.errorMsg.value,
              onRefresh: () => {},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        onPressed: () {},
        child: const Icon(Icons.play_circle_outline_rounded),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Remix.heart_line,
                    size: 20,
                  ),
                  label: Text("订阅"),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Remix.chat_2_line,
                    size: 20,
                  ),
                  label: const Text("评论"),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Remix.download_line,
                    size: 20,
                  ),
                  label: const Text("下载"),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Remix.links_line,
                    size: 20,
                  ),
                  label: const Text("相关"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //信息
        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NetImage(
                  "https://otu1.dodomh.com/images/o/93/00/5a7a72d48c161b052b73770829a7.jpg",
                  width: 120,
                  height: 160,
                  borderRadius: 4,
                ),
                AppStyle.hGap12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "海贼王",
                        style: Get.textTheme.titleMedium,
                      ),
                      AppStyle.vGap8,
                      _buildInfoItems(
                        iconData: Remix.user_smile_line,
                        children: []
                            .map(
                              (e) => GestureDetector(
                                onTap: () => {},
                                child: Text(
                                  e.tagName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.2,
                                    decoration: TextDecoration.underline,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : AppColor.black33,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      _buildInfoItems(
                        iconData: Remix.hashtag,
                        children: []
                            .map(
                              (e) => GestureDetector(
                                onTap: () => {},
                                child: Text(
                                  e.tagName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.2,
                                    decoration: TextDecoration.underline,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : AppColor.black33,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      _buildInfo(
                        title: "人气 ",
                        iconData: Remix.fire_line,
                      ),
                      _buildInfo(
                        title: "订阅 ",
                        iconData: Remix.heart_line,
                      ),
                      _buildInfo(
                        title: "海賊王",
                        iconData: Icons.schedule,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Offstage(
                offstage: false,
                child: Text("vip"),
              ),
            ),
          ],
        ),
        AppStyle.vGap12,
        GestureDetector(
          onTap: () {},
          child: Text(
            "描述",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            maxLines: 999,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AppStyle.vGap12,
        Divider(
          color: Colors.grey.withOpacity(.2),
          height: 1.0,
        ),
      ],
    );
  }

  Widget _buildChapter() {
    var items = <int>[];
    for (var i = 0; i < 100; i++) {
      items.add(i);
    }
    return Column(
      children: items
          .map(
            (i) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: AppStyle.edgeInsetsV8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "標題 (共100话)",
                          style: Get.textTheme.titleSmall,
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
                        label: const Text("升序"),
                      ),
                    ],
                  ),
                ),
                LayoutBuilder(builder: (ctx, constraints) {
                  var count = constraints.maxWidth ~/ 160;
                  if (count < 3) count = 3;

                  return MasonryGridView.count(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 100,
                    itemBuilder: (_, i) {
                      return Tooltip(
                        message: '第 $i 話',
                        child: Stack(
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    Get.textTheme.bodyMedium!.color,
                                textStyle: const TextStyle(fontSize: 14),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size.fromHeight(40),
                              ),
                              onPressed: () {},
                              child: Text(
                                '第 $i 話',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Positioned(
                              left: -2,
                              top: 0,
                              child: Offstage(
                                offstage: false,
                                child: Text("vip"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    crossAxisCount: count,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  );
                })
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildInfo({
    required String title,
    IconData iconData = Icons.tag,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.grey,
            size: 16,
          ),
          AppStyle.hGap8,
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Get.isDarkMode ? Colors.white : AppColor.black33,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItems({
    required List<Widget> children,
    IconData iconData = Icons.tag,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.grey,
            size: 16,
          ),
          AppStyle.hGap8,
          Expanded(
            child: Wrap(
              spacing: 8,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
