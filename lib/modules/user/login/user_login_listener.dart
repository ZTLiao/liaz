import 'package:get/get.dart';
import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_controller.dart';

class UserLoginListener extends EventListener {
  @override
  void onListen(Event event) {
    //我的书架刷新
    Get.find<BookshelfHomeController>().onRefresh();
  }
}
