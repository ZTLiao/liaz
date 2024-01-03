import 'package:get/get.dart';
import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/modules/novel/detail/novel_detail_controller.dart';

class NovelHistoryListener extends EventListener {
  @override
  void onListen(Event event) {
    var source = event.source;
    if (source == null) {
      return;
    }
    var chapterId = source as int;
    Get.find<NovelDetailController>().browseChapterId.value = chapterId;
  }
}
