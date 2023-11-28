import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_asset.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:lottie/lottie.dart';

class AppEmptyWidget extends StatelessWidget {
  final Function()? onRefresh;

  const AppEmptyWidget({this.onRefresh, super.key});

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
                AppAsset.lottiesEmpty,
                width: 200,
                height: 200,
                repeat: false,
              ),
              const Text(
                AppString.empty,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColor.black33),
              )
            ],
          ),
        ),
      ),
    );
  }
}
