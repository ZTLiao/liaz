import 'package:get/get.dart';
import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/modules/download/detail/download_detail_controller.dart';

class DownloadDetailListener extends EventListener {
  @override
  void onListen(Event event) {
    var source = event.source;
    if (source == null) {
      return;
    }
    String taskId = source as String;
    Get.find<DownloadDetailController>().doUpdate(taskId);
  }
}
