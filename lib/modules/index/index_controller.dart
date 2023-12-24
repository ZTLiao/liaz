import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/events/event_bus.dart';

class IndexController extends GetxController {
  final index = RxInt(0);
  final GlobalKey indexKey = GlobalKey();
  final GlobalKey subRouterKey = GlobalKey();

  void setIndex(i) {
    EventBus.instance.publish(AppEvent.navigationTopic, i);
    index.value = i;
  }
}
