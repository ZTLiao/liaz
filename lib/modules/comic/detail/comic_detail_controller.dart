import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';

class ComicDetailController extends BaseController {
  final int comicId;
  var isExpandDescription = RxBool(false);

  ComicDetailController({required this.comicId});
}
