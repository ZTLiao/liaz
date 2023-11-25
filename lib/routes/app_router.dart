import 'package:get/get.dart';
import 'package:liaz/modules/comic/home/comic_home_controller.dart';
import 'package:liaz/modules/index/home/index_home_controller.dart';
import 'package:liaz/modules/index/index_controller.dart';
import 'package:liaz/modules/index/index_page.dart';
import 'package:liaz/modules/novel/home/novel_home_controller.dart';
import 'package:liaz/modules/user/home/user_home_controller.dart';
import 'package:liaz/routes/app_route_path.dart';

class AppRouter {
  AppRouter._();

  static final routes = [
    GetPage(
        name: AppRoutePath.kHome,
        page: () => const IndexPage(),
        bindings: [
          BindingsBuilder.put(() => IndexController()),
          BindingsBuilder.put(() => IndexHomeController()),
          BindingsBuilder.put(() => ComicHomeController()),
          BindingsBuilder.put(() => NovelHomeController()),
          BindingsBuilder.put(() => UserHomeController()),
        ]),
  ];
}
