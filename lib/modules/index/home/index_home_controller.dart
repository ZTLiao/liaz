import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/modules/index/home/index_home_listener.dart';

class IndexHomeController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    EventBus.instance.subscribe(AppEvent.kNavigationTopic, IndexHomeListener());
    tabController = TabController(length: AppConstant.kTabSize, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    EventBus.instance.unSubscribe(AppEvent.kNavigationTopic);
    super.onClose();
  }
}
