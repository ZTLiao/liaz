import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/modules/common/splash/splash_screen_controller.dart';
import 'package:liaz/services/advert_service.dart';

class SplashScreenPage extends StatelessWidget {
  final SplashScreenController controller;

  SplashScreenPage({super.key})
      : controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    var splash = Global.appConfig.splash;
    Widget splashWidget = const SizedBox();
    if (splash.cover.isNotEmpty) {
      splashWidget = FadeTransition(
        opacity: controller.animation,
        child: Obx(
          () => InkWell(
            onTap: controller.skipPage,
            child: ExtendedImage.network(
              controller.cover.value,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      );
    } else {
      splashWidget = AdvertService.instance.buildSplashAdvert(context);
    }
    return splashWidget;
  }
}
