import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_asset.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/tool_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:lottie/lottie.dart';

class AppErrorWidget extends StatelessWidget {
  final Function()? onRefresh;
  final String errorMsg;
  final Error? error;

  const AppErrorWidget(
      {this.errorMsg = StrUtil.empty, this.onRefresh, this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onRefresh?.call();
        },
        child: Padding(
          padding: AppStyle.edgeInsetsA12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                AppAsset.lottiesError,
                width: 260,
                repeat: false,
              ),
              Text(
                "$errorMsg\r\n${AppString.refresh}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Visibility(
                visible: error != null,
                child: Padding(
                  padding: AppStyle.edgeInsetsT12,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      textStyle: Get.textTheme.bodySmall,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      ToolUtil.copyText(
                          "$errorMsg\n${error?.stackTrace?.toString()}");
                      SmartDialog.showToast(AppString.copeid);
                    },
                    child: const Text(AppString.copy),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
