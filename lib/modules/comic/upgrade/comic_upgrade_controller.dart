import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/comic/comic_item_model.dart';
import 'package:liaz/requests/comic_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/comic_service.dart';

class ComicUpgradeController extends BasePageController<ComicItemModel> {
  var comicRequest = ComicRequest();

  @override
  Future<List<ComicItemModel>> getData(int currentPage, int pageSize) async {
    return await comicRequest.comicUpgrade(currentPage, pageSize);
  }

  void onDetail(int comicId) {
    ComicService.instance.toComicDetail(comicId);
  }

  void onReadChapter(int comicChapterId) async {
    var chapters = await comicRequest.getComicCatalogue(comicChapterId);
    AppNavigator.toComicReader(
      comicChapterId: comicChapterId,
      chapters: chapters,
    );
  }
}
