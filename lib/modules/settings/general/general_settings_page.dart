import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/screen_direction_enum.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/modules/settings/general/general_settings_controller.dart';
import 'package:liaz/services/app_settings_service.dart';

class GeneralSettingsPage extends StatelessWidget {
  final GeneralSettingsController controller;

  GeneralSettingsPage({super.key})
      : controller =
            Get.put<GeneralSettingsController>(GeneralSettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('${AppString.general}${AppString.settings}'),
        ),
        body: ListView(
          children: [
            ListTile(
              leading:
                  const Text('${AppString.clearCache}${StrUtil.semicolon}'),
              title: Text(controller.cacheSize.value),
              trailing: OutlinedButton(
                onPressed: controller.cleanCache,
                child: const Text(AppString.clear),
              ),
            ),
            ListTile(
              leading: const Text(
                  '${AppString.screenBrightness}${StrUtil.semicolon}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.nights_stay_outlined),
                  Slider.adaptive(
                    value: AppSettings.screenBrightness.value,
                    onChanged: (value) {
                      AppSettingsService.instance.setScreenBrightness(value);
                    },
                  ),
                  const Icon(Icons.wb_sunny_outlined),
                ],
              ),
            ),
            ListTile(
              leading: const Text(
                AppString.screenDirection,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      AppSettingsService.instance.setScreenDirection(
                          ScreenDirectionEnum.vertical.index);
                    },
                    style: ButtonStyle(
                      side: MaterialStatePropertyAll(
                        BorderSide(
                          color: AppSettings.screenDirection.value ==
                                  ScreenDirectionEnum.vertical.index
                              ? Colors.cyan
                              : Colors.grey,
                        ),
                      ),
                    ),
                    child: Text(
                      AppString.verticalScreenRead,
                      style: TextStyle(
                        color: AppSettings.screenDirection.value ==
                                ScreenDirectionEnum.vertical.index
                            ? Colors.cyan
                            : Colors.grey,
                      ),
                    ),
                  ),
                  AppStyle.hGap4,
                  TextButton(
                    onPressed: () {
                      AppSettingsService.instance.setScreenDirection(
                          ScreenDirectionEnum.horizontal.index);
                    },
                    style: ButtonStyle(
                      side: MaterialStatePropertyAll(
                        BorderSide(
                          color: AppSettings.screenDirection.value ==
                                  ScreenDirectionEnum.horizontal.index
                              ? Colors.cyan
                              : Colors.grey,
                        ),
                      ),
                    ),
                    child: Text(
                      AppString.horizontalScreenRead,
                      style: TextStyle(
                        color: AppSettings.screenDirection.value ==
                                ScreenDirectionEnum.horizontal.index
                            ? Colors.cyan
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Text(
                  '${AppString.downloadForCellular}${StrUtil.semicolon}'),
              trailing: Switch(
                value: AppSettings.downloadAllowCellular.value,
                onChanged: (e) {
                  AppSettingsService.instance.setDownloadAllowCellular(e);
                },
              ),
            ),
            ListTile(
              leading: const Text(
                  '${AppString.downloadTaskNum}${StrUtil.semicolon}'),
              onTap: () {
                controller.setDownloadTask();
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppSettings.downloadTaskCount.value == 0
                        ? AppString.unlimit
                        : AppSettings.downloadTaskCount.toString(),
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
      ),
    );
  }
}
