import 'package:get/get.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_controller.dart';
import 'package:liaz/modules/browse/browse_history_controller.dart';
import 'package:liaz/modules/browse/browse_history_page.dart';
import 'package:liaz/modules/category/home/category_home_controller.dart';
import 'package:liaz/modules/comic/detail/comic_detail_page.dart';
import 'package:liaz/modules/comic/download/comic_download_page.dart';
import 'package:liaz/modules/comic/reader/comic_reader_controller.dart';
import 'package:liaz/modules/comic/reader/comic_reader_page.dart';
import 'package:liaz/modules/common/empty_page.dart';
import 'package:liaz/modules/common/h5/h5_web_view_page.dart';
import 'package:liaz/modules/download/detail/download_detail_controller.dart';
import 'package:liaz/modules/download/detail/download_detail_page.dart';
import 'package:liaz/modules/download/local_download_page.dart';
import 'package:liaz/modules/index/home/index_home_controller.dart';
import 'package:liaz/modules/index/index_controller.dart';
import 'package:liaz/modules/index/index_page.dart';
import 'package:liaz/modules/message/message_board_controller.dart';
import 'package:liaz/modules/message/message_board_page.dart';
import 'package:liaz/modules/novel/detail/novel_detail_page.dart';
import 'package:liaz/modules/novel/download/novel_download_page.dart';
import 'package:liaz/modules/novel/reader/novel_reader_controller.dart';
import 'package:liaz/modules/novel/reader/novel_reader_page.dart';
import 'package:liaz/modules/search/home/search_home_page.dart';
import 'package:liaz/modules/settings/comic/comic_settings_page.dart';
import 'package:liaz/modules/settings/general/general_settings_page.dart';
import 'package:liaz/modules/settings/novel/novel_settings_page.dart';
import 'package:liaz/modules/settings/settings_page.dart';
import 'package:liaz/modules/user/detail/user_detail_page.dart';
import 'package:liaz/modules/user/home/user_home_controller.dart';
import 'package:liaz/modules/user/login/user_login_page.dart';
import 'package:liaz/modules/user/register/user_register_page.dart';
import 'package:liaz/modules/user/forget/forget_password_page.dart';
import 'package:liaz/modules/user/set/set_password_page.dart';
import 'package:liaz/routes/app_route.dart';

class AppRouter {
  AppRouter._();

  static final routes = [
    GetPage(
      name: AppRoute.kRoot,
      page: () => const EmptyPage(),
    ),
    GetPage(
      name: AppRoute.kIndex,
      page: () => const IndexPage(),
      bindings: [
        BindingsBuilder.put(() => IndexController()),
        BindingsBuilder.put(() => IndexHomeController()),
        BindingsBuilder.put(() => CategoryHomeController()),
        BindingsBuilder.put(() => BookshelfHomeController()),
        BindingsBuilder.put(() => UserHomeController()),
      ],
    ),
    GetPage(
      name: AppRoute.kSearch,
      page: () => SearchHomePage(),
    ),
    GetPage(
      name: AppRoute.kSettings,
      page: () => SettingsPage(),
    ),
    GetPage(
      name: AppRoute.kGeneralSettings,
      page: () => GeneralSettingsPage(),
    ),
    GetPage(
      name: AppRoute.kComicSettings,
      page: () => const ComicSettingsPage(),
    ),
    GetPage(
      name: AppRoute.kNovelSettings,
      page: () => const NovelSettingsPage(),
    ),
    GetPage(
      name: AppRoute.kComicReader,
      page: () => const ComicReaderPage(),
      binding: BindingsBuilder.put(
        () => ComicReaderController(
          comicChapterId: Get.arguments['comicChapterId'],
          chapters: Get.arguments['chapters'],
        ),
      ),
    ),
    GetPage(
      name: AppRoute.kNovelReader,
      page: () => const NovelReaderPage(),
      binding: BindingsBuilder.put(
        () => NovelReaderController(
          novelChapterId: Get.arguments['novelChapterId'],
          chapters: Get.arguments['chapters'],
        ),
      ),
    ),
    GetPage(
      name: AppRoute.kWebView,
      page: () => H5WebViewPage(
        url: Get.arguments['url'],
      ),
    ),
    GetPage(
      name: AppRoute.kComicDetail,
      page: () => ComicDetailPage(
        ComicDetailModel.fromJson(
          Get.arguments['detail'],
        ),
      ),
    ),
    GetPage(
      name: AppRoute.kNovelDetail,
      page: () => NovelDetailPage(
        NovelDetailModel.fromJson(
          Get.arguments['detail'],
        ),
      ),
    ),
    GetPage(
      name: AppRoute.kUserLogin,
      page: () => UserLoginPage(),
    ),
    GetPage(
      name: AppRoute.kUserRegister,
      page: () => UserRegisterPage(),
    ),
    GetPage(
      name: AppRoute.kForgetPassword,
      page: () => ForgetPasswordPage(),
    ),
    GetPage(
      name: AppRoute.kSetPassword,
      page: () => SetPasswordPage(),
    ),
    GetPage(
      name: AppRoute.kUserDetail,
      page: () => UserDetailPage(),
    ),
    GetPage(
      name: AppRoute.kComicDownload,
      page: () => ComicDownloadPage(
        ComicDetailModel.fromJson(
          Get.arguments['detail'],
        ),
      ),
    ),
    GetPage(
      name: AppRoute.kNovelDownload,
      page: () => NovelDownloadPage(
        NovelDetailModel.fromJson(
          Get.arguments['detail'],
        ),
      ),
    ),
    GetPage(
      name: AppRoute.kLocalDownload,
      page: () => LocalDownloadPage(),
    ),
    GetPage(
      name: AppRoute.kDownloadDetail,
      page: () => const DownloadDetailPage(),
      binding: BindingsBuilder.put(
        () => DownloadDetailController(
          title: Get.arguments['title'],
          taskIds: Get.arguments['taskIds'],
        ),
      ),
    ),
    GetPage(
      name: AppRoute.kBrowseHistory,
      page: () => const BrowseHistoryPage(),
      binding: BindingsBuilder.put(
        () => BrowseHistoryController(),
      ),
    ),
    GetPage(
      name: AppRoute.kMessageBoard,
      page: () => const MessageBoardPage(),
      binding: BindingsBuilder.put(
        () => MessageBoardController(),
      ),
    ),
  ];
}
