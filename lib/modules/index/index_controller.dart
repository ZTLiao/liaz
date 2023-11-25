import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:liaz/app/events/app_event_publisher.dart';
import 'package:liaz/modules/index/index_event.dart';

class IndexController extends GetxController {
  final index = RxInt(0);
  final showContent = RxBool(false);
  final GlobalKey indexKey = GlobalKey();
  final GlobalKey subRouterKey = GlobalKey();

  void setIndex(i) {
    AppEventPublisher.instance.publishEvent(IndexEvent(i));
    index.value = i;
  }
}
