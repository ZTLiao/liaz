import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';

class ComicDownloadController extends BaseController {
  final RxList<int> chapterIds = RxList([]);

  final ComicDetailModel comicDetail;

  ComicDownloadController({
    required this.comicDetail,
  });
}
