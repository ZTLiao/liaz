import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/novel/novel_item_model.dart';
import 'package:liaz/requests/novel_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/novel_service.dart';

class NovelUpgradeController extends BasePageController<NovelItemModel> {
  var novelRequest = NovelRequest();

  @override
  Future<List<NovelItemModel>> getData(int currentPage, int pageSize) async {
    return await novelRequest.novelUpgrade(currentPage, pageSize);
  }

  void onDetail(int novelId) {
    NovelService.instance.toNovelDetail(novelId);
  }

  void onReadChapter(int novelChapterId) async {
    NovelService.instance.onReadChapter(novelChapterId);
  }
}
