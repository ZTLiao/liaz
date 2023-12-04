import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';

class ComicDetailController extends BaseController {
  final int id;
  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);

  ComicDetailController({required this.id});
}
