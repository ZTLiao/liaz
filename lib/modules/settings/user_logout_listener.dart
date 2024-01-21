import 'package:get/get.dart';
import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_controller.dart';
import 'package:liaz/modules/index/recommend/index_recommend_controller.dart';
import 'package:liaz/modules/user/home/user_home_controller.dart';

class UserLogoutListener extends EventListener {
  @override
  void onListen(Event event) {
    //我的书架刷新
    Get.find<BookshelfHomeController>().onRefresh();
    //更新用户
    Get.find<UserHomeController>().updateUser();
    //首页推荐
    Get.find<IndexRecommendController>().onRefresh();
  }
}
