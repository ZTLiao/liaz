import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/services/app_version_service.dart';

class IndexController extends GetxController {
  final index = RxInt(0);
  final GlobalKey indexKey = GlobalKey();
  final GlobalKey subRouterKey = GlobalKey();

  @override
  void onInit() {
    AppVersionService.instance.showUpdateDialog();
    super.onInit();
  }

  void setIndex(i) {
    EventBus.instance.publish(AppEvent.kNavigationTopic, i);
    index.value = i;
  }
}
