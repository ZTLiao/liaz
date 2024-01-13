import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';

class NovelDownloadController extends BaseController {
  final RxList<int> chapterIds = RxList([]);

  final NovelDetailModel novelDetail;

  NovelDownloadController({
    required this.novelDetail,
  });
}
