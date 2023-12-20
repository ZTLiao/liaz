import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';

class ComicDetailController extends BaseController {
  final ComicDetailModel detail;

  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);

  ComicDetailController({required this.detail});
}
