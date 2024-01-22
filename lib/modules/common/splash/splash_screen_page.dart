import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_asset.dart';
import 'package:liaz/modules/common/splash/splash_screen_controller.dart';

class SplashScreenPage extends StatelessWidget {
  final SplashScreenController controller;

  SplashScreenPage({super.key})
      : controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller.animation,
      child: Center(
        child: Image.asset(
          AppAsset.imageLogo,
          height: 80,
        ),
      ),
    );
  }
}
