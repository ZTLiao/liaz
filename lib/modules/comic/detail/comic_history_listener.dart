import 'package:get/get.dart';
import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/modules/comic/detail/comic_detail_controller.dart';

class ComicHistoryListener extends EventListener {
  @override
  void onListen(Event event) {
    var source = event.source;
    if (source == null) {
      return;
    }
    var chapterId = source as int;
    Get.find<ComicDetailController>().browseChapterId.value = chapterId;
  }
}
