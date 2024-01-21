import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/services/app_settings_service.dart';

class ComicSettingsPage extends StatelessWidget {
  const ComicSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('${AppString.comic}${AppString.settings}'),
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
                    groupValue: AppSettings.comicReaderDirection.value,
                    onChanged: (value) {
                      AppSettingsService.instance
                          .setComicReaderDirection(value!);
                    },
                  ),
                  Text(
                    AppString.rightToLeft,
                    style: TextStyle(
                      color: AppSettings.comicReaderDirection.value ==
                              ReaderDirectionEnum.leftToRight.index
                          ? Colors.cyan
                          : Colors.grey,
                    ),
                  ),
                  Radio(
                    value: ReaderDirectionEnum.rightToLeft.index,
                    groupValue: AppSettings.comicReaderDirection.value,
                    onChanged: (value) {
                      AppSettingsService.instance
                          .setComicReaderDirection(value!);
                    },
                  ),
                  Text(
                    AppString.rightToLeft,
                    style: TextStyle(
                      color: AppSettings.comicReaderDirection.value ==
                              ReaderDirectionEnum.rightToLeft.index
                          ? Colors.cyan
                          : Colors.grey,
                    ),
                  ),
                  Radio(
                    value: ReaderDirectionEnum.upToDown.index,
                    groupValue: AppSettings.comicReaderDirection.value,
                    onChanged: (value) {
                      AppSettingsService.instance
                          .setComicReaderDirection(value!);
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
                value: AppSettings.comicReaderLeftHandMode.value,
                onChanged: (e) {
                  AppSettingsService.instance.setComicReaderLeftHandMode(e);
                },
              ),
            ),
            ListTile(
              leading:
                  const Text('${AppString.fullScreen}${StrUtil.semicolon}'),
              trailing: Switch(
                value: AppSettings.comicReaderFullScreen.value,
                onChanged: (e) {
                  AppSettingsService.instance.setComicReaderFullScreen(e);
                },
              ),
            ),
            ListTile(
              leading:
                  const Text('${AppString.showStatus}${StrUtil.semicolon}'),
              trailing: Switch(
                value: AppSettings.comicReaderShowStatus.value,
                onChanged: (e) {
                  AppSettingsService.instance.setComicReaderShowStatus(e);
                },
              ),
            ),
            ListTile(
              leading:
                  const Text('${AppString.pageAnimation}${StrUtil.semicolon}'),
              trailing: Switch(
                value: AppSettings.comicReaderPageAnimation.value,
                onChanged: (e) {
                  AppSettingsService.instance.setComicReaderPageAnimation(e);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
