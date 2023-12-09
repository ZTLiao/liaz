import 'package:get/get.dart';
import 'package:liaz/app/enums/app_index_enum.dart';
import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/modules/index/home/index_home_controller.dart';

class IndexHomeListener extends EventListener {
  @override
  void onListen(Event event) {
    if (event.source is! int ||
        (event.source as int) != AppIndexEnum.kIndex.index) {
      return;
    }
    var tabIndex = Get.find<IndexHomeController>().tabController.index;
    Log.i("tabIndex : $tabIndex");
    if (tabIndex == 0) {
    } else if (tabIndex == 1) {
    } else if (tabIndex == 2) {}
  }
}
