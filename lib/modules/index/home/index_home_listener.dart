import 'package:get/get.dart';
import 'package:liaz/app/enums/app_index_enum.dart';
import 'package:liaz/app/events/app_event_listener.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/modules/index/home/index_home_controller.dart';
import 'package:liaz/modules/index/index_event.dart';

class IndexHomeListener extends AppEventListener<IndexEvent> {
  IndexHomeListener() : super(IndexEvent(AppIndexEnum.kIndex.index));

  @override
  void onEvent(IndexEvent event) {
    if (event.source != AppIndexEnum.kIndex.index) {
      return;
    }
    var tabIndex = Get.find<IndexHomeController>().tabController.index;
    Log.i("tabIndex : $tabIndex");
  }
}
