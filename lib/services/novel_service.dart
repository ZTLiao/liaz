import 'package:get/get.dart';
import 'package:liaz/requests/novel_request.dart';
import 'package:liaz/routes/app_navigator.dart';

class NovelService {
  static NovelService get instance => Get.find<NovelService>();

  final _novelRequest = NovelRequest();

  void toNovelDetail(int novelId) async {
    _novelRequest
        .novelDetail(novelId)
        .then((value) => {AppNavigator.toNovelDetail(value.toJson())});
  }
}
