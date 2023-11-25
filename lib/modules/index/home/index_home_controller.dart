import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/events/app_event_publisher.dart';
import 'package:liaz/modules/index/home/index_home_listener.dart';

class IndexHomeController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  var listener = IndexHomeListener();

  @override
  void onInit() {
    AppEventPublisher.instance.addListener(listener);
    tabController = TabController(length: AppConstant.kTabSize, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    AppEventPublisher.instance.removeListener(listener);
    super.onClose();
  }
}
