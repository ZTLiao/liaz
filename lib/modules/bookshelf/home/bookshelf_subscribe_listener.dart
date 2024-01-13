import 'package:get/get.dart';
import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_controller.dart';

class BookshelfSubscribeListener extends EventListener {
  @override
  void onListen(Event event) {
    Get.find<BookshelfHomeController>().onRefresh();
  }
}
