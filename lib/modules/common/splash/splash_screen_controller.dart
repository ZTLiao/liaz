import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/routes/app_navigator.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        AppNavigator.toIndex(
          replace: true,
        );
      }
    });
    _animationController.forward();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
