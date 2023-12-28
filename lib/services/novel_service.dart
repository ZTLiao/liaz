import 'package:get/get.dart';
import 'package:liaz/requests/novel_request.dart';
import 'package:liaz/routes/app_navigator.dart';

class NovelService {
  static NovelService get instance => Get.find<NovelService>();

  var novelRequest = NovelRequest();

  void toNovelDetail(int novelId) async {
    novelRequest
        .novelDetail(novelId)
        .then((value) => {AppNavigator.toNovelDetail(value.toJson())});
  }
}
