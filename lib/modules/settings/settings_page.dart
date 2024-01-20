import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/settings/settings_controller.dart';
import 'package:liaz/services/app_settings_service.dart';

class SettingsPage extends StatelessWidget {
  final int index;
  final controller = Get.put<SettingsController>(SettingsController());

  SettingsPage({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: index,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 56),
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor:
              Get.isDarkMode ? Colors.white70 : Colors.black87,
              tabs: const [
                Tab(text: "常规"),
                Tab(text: "漫画"),
                Tab(text: "小说"),
                Tab(text: "下载"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            buildGeneralSettings(),
            buildComicSettings(),
            buildNovelSettings(),
            buildDownloadSettings(),
          ],
        ),
      ),
    );
  }

  Widget buildGeneralSettings() {
    return Obx(
          () => ListView(
        padding: AppStyle.edgeInsetsA12,
        children: [
          ListTile(
            title: const Text("清除图片缓存"),
            subtitle: Text(controller.imageCacheSize.value),
            trailing: OutlinedButton(
              onPressed: () {
                controller.cleanImageCache();
              },
              child: const Text("清除"),
            ),
          ),
          ListTile(
            title: const Text("清除小说缓存"),
            subtitle: Text(controller.novelCacheSize.value),
            trailing: OutlinedButton(
              onPressed: () {},
              child: const Text("清除"),
            ),
          ),
          SwitchListTile(
            value: AppSettings.useSystemFontSize.value,
            onChanged: (e) {
              AppSettingsService.instance.setUseSystemFontSize(e);
            },
            title: const Text("字体大小跟随系统"),
            subtitle: const Text("开启可能会有布局错乱"),
          ),
        ],
      ),
    );
  }

  Widget buildComicSettings() {
    return Obx(
          () => ListView(
        padding: AppStyle.edgeInsetsA12,
        children: [
          SwitchListTile(
            value: AppSettings.comicReaderHD.value,
            onChanged: (e) {
              AppSettingsService.instance.setComicReaderHD(e);
            },
            title: const Text("优先加载高清图"),
            subtitle: const Text("部分单行本可能未分页"),
          ),
          ListTile(
            title: const Text("阅读方向"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSelectedButton(
                  onTap: () {
                    AppSettingsService.instance.setComicReaderDirection(0);
                  },
                  selected: AppSettings.comicReaderDirection.value == 0,
                  child: const Icon(Icons.arrow_right),
                ),
                AppStyle.hGap8,
                buildSelectedButton(
                  onTap: () {
                    AppSettingsService.instance.setComicReaderDirection(2);
                  },
                  selected: AppSettings.comicReaderDirection.value == 2,
                  child: const Icon(Icons.arrow_left),
                ),
                AppStyle.hGap8,
                buildSelectedButton(
                  onTap: () {
                    AppSettingsService.instance.setComicReaderDirection(1);
                  },
                  selected: AppSettings.comicReaderDirection.value == 1,
                  child: const Icon(Icons.arrow_circle_down),
                )
              ],
            ),
          ),
          SwitchListTile(
            value: AppSettings.comicReaderLeftHandMode.value,
            onChanged: (e) {
              AppSettingsService.instance.setComicReaderLeftHandMode(e);
            },
            title: const Text("操作反转"),
            subtitle: const Text("点击左侧下一页，右侧上一页"),
          ),
          SwitchListTile(
            value: AppSettings.comicReaderFullScreen.value,
            onChanged: (e) {
              AppSettingsService.instance.setComicReaderFullScreen(e);
            },
            title: const Text("全屏阅读"),
          ),
          SwitchListTile(
            value: AppSettings.comicReaderShowStatus.value,
            onChanged: (e) {
              AppSettingsService.instance.setComicReaderShowStatus(e);
            },
            title: const Text("显示状态信息"),
          ),
          SwitchListTile(
            value: AppSettings.comicReaderShowViewPoint.value,
            onChanged: (e) {
              AppSettingsService.instance.setComicReaderShowViewPoint(e);
            },
            title: const Text("显示吐槽"),
          ),
          SwitchListTile(
            value: AppSettings.comicReaderOldViewPoint.value,
            onChanged: (e) {
              AppSettingsService.instance.setComicReaderOldViewPoint(e);
            },
            title: const Text("旧版吐槽"),
          ),
          SwitchListTile(
            value: AppSettings.comicReaderPageAnimation.value,
            onChanged: (e) {
              AppSettingsService.instance.setComicReaderPageAnimation(e);
            },
            title: const Text("翻页动画"),
          ),
        ],
      ),
    );
  }

  Widget buildNovelSettings() {
    return Obx(
          () => ListView(
        padding: AppStyle.edgeInsetsA12,
        children: [
          ListTile(
            title: const Text("阅读方向"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSelectedButton(
                  onTap: () {
                    AppSettingsService.instance.setNovelReaderDirection(0);
                  },
                  selected: AppSettings.novelReaderDirection.value == 0,
                  child: const Icon(Icons.arrow_right),
                ),
                AppStyle.hGap8,
                buildSelectedButton(
                  onTap: () {
                    AppSettingsService.instance.setNovelReaderDirection(2);
                  },
                  selected: AppSettings.novelReaderDirection.value == 2,
                  child: const Icon(Icons.arrow_left),
                ),
                AppStyle.hGap8,
                buildSelectedButton(
                  onTap: () {
                    AppSettingsService.instance.setNovelReaderDirection(1);
                  },
                  selected: AppSettings.novelReaderDirection.value == 1,
                  child: const Icon(Icons.arrow_circle_down),
                )
              ],
            ),
          ),
          SwitchListTile(
            value: AppSettings.novelReaderLeftHandMode.value,
            onChanged: (e) {
              AppSettingsService.instance.setNovelReaderLeftHandMode(e);
            },
            title: const Text("操作反转"),
            subtitle: const Text("点击左侧下一页，右侧上一页"),
          ),
          // SwitchListTile(
          //   value: settings.novelReaderFullScreen.value,
          //   onChanged: (e) {
          //     settings.setNovelReaderFullScreen(e);
          //   },
          //   title: const Text("全屏阅读"),
          // ),
          SwitchListTile(
            value: AppSettings.novelReaderShowStatus.value,
            onChanged: (e) {
              AppSettingsService.instance.setNovelReaderShowStatus(e);
            },
            title: const Text("显示状态信息"),
          ),
          SwitchListTile(
            value: AppSettings.novelReaderPageAnimation.value,
            onChanged: (e) {
              AppSettingsService.instance.setNovelReaderPageAnimation(e);
            },
            title: const Text("翻页动画"),
          ),
          ListTile(
            title: const Text("字体大小"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () {
                    AppSettingsService.instance.setNovelReaderFontSize(
                      AppSettings.novelReaderFontSize.value + 1,
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                ),
                AppStyle.hGap12,
                Text("${AppSettings.novelReaderFontSize.value}"),
                AppStyle.hGap12,
                OutlinedButton(
                  onPressed: () {
                    AppSettingsService.instance.setNovelReaderFontSize(
                      AppSettings.novelReaderFontSize.value - 1,
                    );
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("行距"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () {
                    AppSettingsService.instance.setNovelReaderLineSpacing(
                      AppSettings.novelReaderLineSpacing.value + 0.1,
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                ),
                AppStyle.hGap12,
                Text((AppSettings.novelReaderLineSpacing.value)
                    .toStringAsFixed(1)),
                AppStyle.hGap12,
                OutlinedButton(
                  onPressed: () {
                    AppSettingsService.instance.setNovelReaderLineSpacing(
                      AppSettings.novelReaderLineSpacing.value - 0.1,
                    );
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("阅读主题"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: AppColor.novelThemes.keys
                  .map(
                    (e) => GestureDetector(
                  onTap: () {
                    AppSettingsService.instance.setNovelReaderTheme(e);
                  },
                  child: Container(
                    margin: AppStyle.edgeInsetsL8,
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: AppColor.novelThemes[e]!.first,
                      borderRadius: AppStyle.radius24,
                    ),
                    child: Visibility(
                      visible:
                      AppColor.novelThemes.keys.toList().indexOf(e) ==
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
          Container(
            margin: AppStyle.edgeInsetsV12,
            padding: AppStyle.edgeInsetsA8,
            decoration: BoxDecoration(
              borderRadius: AppStyle.radius4,
              color: AppColor
                  .novelThemes[AppSettings.novelReaderTheme]!.first,
            ),
            child: Text(
              """这是一段测试文字，可以预览上面的设置效果。

　　晋太元中，武陵人捕鱼为业。缘溪行，忘路之远近。忽逢桃花林，夹岸数百步，中无杂树，芳草鲜美，落英缤纷。渔人甚异之，复前行，欲穷其林。
　　林尽水源，便得一山，山有小口，仿佛若有光。便舍船，从口入。初极狭，才通人。复行数十步，豁然开朗。土地平旷，屋舍俨然，有良田、美池、桑竹之属。阡陌交通，鸡犬相闻。其中往来种作，男女衣着，悉如外人。黄发垂髫，并怡然自乐……""",
              //不需要跟随系统
              textScaleFactor: 1.0,
              style: TextStyle(
                fontSize:
                AppSettings.novelReaderFontSize.value.toDouble(),
                height: AppSettings.novelReaderLineSpacing.value,
                color: AppColor
                    .novelThemes[AppSettings.novelReaderTheme]!.last,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDownloadSettings() {
    return Obx(
          () => ListView(
        padding: AppStyle.edgeInsetsA12,
        children: [
          SwitchListTile(
            value: AppSettings.downloadAllowCellular.value,
            onChanged: (e) {
              AppSettingsService.instance.setDownloadAllowCellular(e);
            },
            title: const Text("允许使用流量下载"),
          ),
          ListTile(
            title: const Text("漫画最大任务数"),
            onTap: () {
              controller.setDownloadComicTask();
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppSettings.downloadComicTaskCount.value == 0
                      ? "无限制"
                      : AppSettings.downloadComicTaskCount.toString(),
                ),
                AppStyle.hGap4,
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("小说最大任务数"),
            onTap: () {
              controller.setDownloadNovelTask();
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppSettings.downloadNovelTaskCount.value == 0
                      ? "无限制"
                      : AppSettings.downloadNovelTaskCount.toString(),
                ),
                AppStyle.hGap4,
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectedButton(
      {required Widget child, bool selected = false, Function()? onTap}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: selected ? Colors.blue : Colors.grey,
        side: BorderSide(
          color: selected ? Colors.blue : Colors.grey,
        ),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
