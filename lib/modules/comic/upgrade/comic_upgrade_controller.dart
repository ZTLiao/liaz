import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/comic/comic_item_model.dart';
import 'package:liaz/requests/comic_request.dart';

class ComicUpgradeController extends BasePageController<ComicItemModel> {
  var comicRequest = ComicRequest();

  @override
  Future<List<ComicItemModel>> getData(int currentPage, int pageSize) async {
    return await comicRequest.comicUpgrade(currentPage, pageSize);
  }
}
