import 'package:get/get.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/http/request.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/models/novel/novel_volume_model.dart';
import 'package:liaz/requests/file_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/user_service.dart';

class NovelDetailController extends BaseController {
  final NovelDetailModel detail;
  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);
  var isSubscribe = RxBool(false);
  var isExpandPreview = RxBool(false);
  var chapterIndex = RxInt(0);
  var content = RxString(StrUtil.empty);

  NovelDetailController({required this.detail}) {
    isSubscribe.value = detail.isSubscribe;
  }

  void subscribe() {
    UserService.instance.novelSubscribe(
        detail.novelId, isSubscribe.value ? YesOrNo.no : YesOrNo.yes);
    isSubscribe.value = !isSubscribe.value;
  }

  void onReadChapter(NovelVolumeModel volume) {
    var chapters = volume.chapters;
    AppNavigator.toNovelReader(
      novelChapterId: chapters[chapterIndex.value].novelChapterId,
      chapters: chapters,
    );
  }

  void onPreview(int i, NovelVolumeModel volume) async {
    var index = chapterIndex.value;
    if (index != i) {
      isExpandPreview.value = true;
    } else {
      isExpandPreview.value = !isExpandPreview.value;
    }
    content.value = StrUtil.empty;
    chapterIndex.value = i;
    var path = volume.chapters[i].paths[0];
    path = await FileRequest().getObject(path);
    content.value = await Request.instance.getResource(path);
  }

  void share() {
    if (detail.novelId == 0) {
      return;
    }
    ShareUtil.share(
      'https://www.baidu.com',
      content: detail.title,
    );
  }
}
