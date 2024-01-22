import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_asset.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:lottie/lottie.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: AppStyle.edgeInsetsA12,
          child: LottieBuilder.asset(
            AppAsset.lottiesLoading,
            width: 200,
          ),
        ),
      ),
    );
  }
}
