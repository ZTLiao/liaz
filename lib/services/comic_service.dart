import 'package:get/get.dart';
import 'package:liaz/requests/comic_request.dart';
import 'package:liaz/routes/app_navigator.dart';

class ComicService {
  static ComicService get instance => Get.find<ComicService>();

  final _comicRequest = ComicRequest();

  void toComicDetail(int comicId) async {
    _comicRequest
        .comicDetail(comicId)
        .then((value) => {AppNavigator.toComicDetail(value.toJson())});
  }
}
