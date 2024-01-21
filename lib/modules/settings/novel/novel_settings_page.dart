import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/services/app_settings_service.dart';
import 'package:liaz/widgets/toolbar/number_controller_widget.dart';

class NovelSettingsPage extends StatelessWidget {
  const NovelSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('${AppString.novel}${AppString.settings}'),
        ),
        body: ListView(
          children: [
            ListTile(
              leading:
                  const Text('${AppString.readDirection}${StrUtil.semicolon}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    value: ReaderDirectionEnum.leftToRight.index,
                    groupValue: AppSettings.novelReaderDirection.value,
                    onChanged: (value) {
                      AppSettingsService.instance
                          .setNovelReaderDirection(value!);
                    },
                  ),
                  Text(
                    AppString.rightToLeft,
                    style: TextStyle(
                      color: AppSettings.novelReaderDirection.value ==
                              ReaderDirectionEnum.leftToRight.index
                          ? Colors.cyan
                          : Colors.grey,
                    ),
                  ),
                  Radio(
                    value: ReaderDirectionEnum.rightToLeft.index,
                    groupValue: AppSettings.novelReaderDirection.value,
                    onChanged: (value) {
                      AppSettingsService.instance
                          .setNovelReaderDirection(value!);
                    },
                  ),
                  Text(
                    AppString.rightToLeft,
                    style: TextStyle(
                      color: AppSettings.novelReaderDirection.value ==
                              ReaderDirectionEnum.rightToLeft.index
                          ? Colors.cyan
                          : Colors.grey,
                    ),
                  ),
                  Radio(
                    value: ReaderDirectionEnum.upToDown.index,
                    groupValue: AppSettings.novelReaderDirection.value,
                    onChanged: (value) {
                      AppSettingsService.instance
                          .setNovelReaderDirection(value!);
                    },
                  ),
                  Text(
                    AppString.upToDown,
                    style: TextStyle(
                      color: AppSettings.comicReaderDirection.value ==
                              ReaderDirectionEnum.upToDown.index
                          ? Colors.cyan
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Text('${AppString.pageMode}${StrUtil.semicolon}'),
              trailing: Switch(
                value: AppSettings.novelReaderLeftHandMode.value,
                onChanged: (e) {
                  AppSettingsService.instance.setNovelReaderLeftHandMode(e);
                },
              ),
            ),
            ListTile(
              leading:
                  const Text('${AppString.showStatus}${StrUtil.semicolon}'),
              trailing: Switch(
                value: AppSettings.novelReaderShowStatus.value,
                onChanged: (e) {
                  AppSettingsService.instance.setNovelReaderShowStatus(e);
                },
              ),
            ),
            ListTile(
              leading:
                  const Text('${AppString.pageAnimation}${StrUtil.semicolon}'),
              trailing: Switch(
                value: AppSettings.novelReaderPageAnimation.value,
                onChanged: (e) {
                  AppSettingsService.instance.setNovelReaderPageAnimation(e);
                },
              ),
            ),
            ListTile(
              leading: const Text('${AppString.fontSize}${StrUtil.semicolon}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NumberControllerWidget(
                    numText: '${AppSettings.novelReaderFontSize.value}',
                    width: 100,
                    addValueChanged: (value) {
                      AppSettingsService.instance.setNovelReaderFontSize(
                        AppSettings.novelReaderFontSize.value + 1,
                      );
                    },
                    removeValueChanged: (value) {
                      AppSettingsService.instance.setNovelReaderFontSize(
                        AppSettings.novelReaderFontSize.value - 1,
                      );
                    },
                    updateValueChanged: (value) {
                      AppSettingsService.instance.setNovelReaderFontSize(
                        value,
                      );
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Text('${AppString.lineWidth}${StrUtil.semicolon}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NumberControllerWidget(
                    numText: (AppSettings.novelReaderLineSpacing.value)
                        .toStringAsFixed(1),
                    width: 100,
                    addValueChanged: (value) {
                      AppSettingsService.instance.setNovelReaderLineSpacing(
                        AppSettings.novelReaderLineSpacing.value + 0.1,
                      );
                    },
                    removeValueChanged: (value) {
                      AppSettingsService.instance.setNovelReaderLineSpacing(
                        AppSettings.novelReaderLineSpacing.value - 0.1,
                      );
                    },
                    updateValueChanged: (value) {
                      AppSettingsService.instance.setNovelReaderLineSpacing(
                        value,
                      );
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Text('${AppString.readTheme}${StrUtil.semicolon}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: AppColor.novelThemes.keys
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          AppSettingsService.instance.setNovelReaderTheme(e);
                        },
                        child: Container(
                          margin: AppStyle.edgeInsetsL24,
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
          ],
        ),
      ),
    );
  }
}
