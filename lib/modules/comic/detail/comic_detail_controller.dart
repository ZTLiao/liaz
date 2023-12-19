import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/requests/comic_request.dart';

class ComicDetailController extends BaseController {
  final int comicId;
  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);

  var comicRequest = ComicRequest();

  var detail = Rx(ComicDetailModel.empty());

  ComicDetailController({required this.comicId});

  @override
  void onInit() async {
    detail.value = await comicRequest.comicDetail(comicId);
    super.onInit();
  }
}
