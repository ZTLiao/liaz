import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/app/utils/tool_util.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShareUtil {
  /// 分享
  static void share(String url, {String content = StrUtil.empty}) {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      useSafeArea: true,
      backgroundColor: Get.theme.cardColor,
      builder: (context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text(AppString.copyLink),
              onTap: () {
                Get.back();
                ToolUtil.copyText(url);
              },
            ),
            Visibility(
              visible: content.isNotEmpty,
              child: ListTile(
                leading: const Icon(Icons.copy),
                title: const Text(AppString.copyTitleAndLink),
                onTap: () {
                  Get.back();
                  ToolUtil.copyText("$content\n$url");
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text(AppString.openBrower),
              onTap: () {
                Get.back();
                launchUrlString(url, mode: LaunchMode.externalApplication);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text(AppString.shareSystem),
              onTap: () {
                Get.back();
                Share.share(content.isEmpty ? url : "$content\n$url");
              },
            ),
          ],
        ),
      ),
    );
  }
}
