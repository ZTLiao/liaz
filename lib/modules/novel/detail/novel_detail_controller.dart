import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';

class NovelDetailController extends BaseController {
  final int id;
  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);
  NovelDetailController({required this.id});
}