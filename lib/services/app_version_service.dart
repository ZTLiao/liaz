import 'package:flutter/material.dart';
import 'package:flutter_app_update/flutter_app_update.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/enums/version_status_enum.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/version/app_version_model.dart';
import 'package:liaz/requests/app_version_request.dart';
import 'package:liaz/services/file_item_service.dart';

class AppVersionService extends GetxService {
  static AppVersionService get instance {
    if (Get.isRegistered<AppVersionService>()) {
      return Get.find<AppVersionService>();
    }
    return Get.put(AppVersionService());
  }

  final _appVersionRequest = AppVersionRequest();

  showUpdateDialog() async {
    var appVersion = await _appVersionRequest.checkUpdate();
    if (appVersion == null) {
      return;
    }
    _showUpdateDialog(appVersion);
  }

  _showUpdateDialog(AppVersionModel appVersion) async {
    var status = appVersion.status;
    if (status != VersionStatusEnum.suggest.index &&
        status != VersionStatusEnum.force.index) {
      return;
    }
    var packageInfo = Global.packageInfo;
    var appName = packageInfo.appName;
    var version = appVersion.appVersion;
    var fileMd5 = appVersion.fileMd5;
    var description = appVersion.description;
    if (description.isNotEmpty) {
      description = description.replaceAll('\\n', '\n');
    }
    var downloadLink =
        await FileItemService.instance.getObject(appVersion.downloadLink);
    bool forcedUpgrade = status == VersionStatusEnum.force.index;
    showDialog(
      context: Get.context!,
      barrierDismissible: !forcedUpgrade,
      builder: (BuildContext context) {
        return PopScope(
          onPopInvoked: (didPop) => Future.value(!forcedUpgrade),
          child: AlertDialog(
            title: Text(
                '${AppString.discoveryNewVersion}${StrUtil.space}$version'),
            content: Text(appVersion.description),
            actions: <Widget>[
              if (!forcedUpgrade)
                TextButton(
                  child: const Text(AppString.cancel),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              TextButton(
                child: const Text(AppString.levelUp),
                onPressed: () {
                  UpdateModel model = UpdateModel(
                    downloadLink,
                    '$appName${StrUtil.underline}$version.apk',
                    'ic_launcher',
                    downloadLink,
                    apkMD5: fileMd5,
                  );
                  AzhonAppUpdate.update(model).then((value) => Log.d('$value'));
                  if (!forcedUpgrade) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void checkUpdate() async {
    var appVersion = await _appVersionRequest.checkUpdate();
    if (appVersion == null) {
      SmartDialog.showToast(AppString.alreadyLatestVersion);
      return;
    }
    _showUpdateDialog(appVersion);
  }
}
