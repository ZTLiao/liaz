import 'package:get/get.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/novel_service.dart';

class RecommendService {
  static RecommendService get instance => Get.find<RecommendService>();

  void onDetail(ItemModel item) {
    var skipType = item.skipType;
    var skipValue = item.skipValue;
    var objId = item.objId;
    //H5
    if (SkipTypeEnum.h5.index == skipType) {
      AppNavigator.toWebView(skipValue!);
    } else {
      var isUpgrade = item.isUpgrade;
      if (isUpgrade != null && isUpgrade == YesOrNo.yes) {
        //漫画
        if (SkipTypeEnum.comic.index == skipType) {
          ComicService.instance.toReadChapter(int.parse(skipValue!));
          //小说
        } else if (SkipTypeEnum.novel.index == skipType) {
          NovelService.instance.toReadChapter(int.parse(skipValue!));
        }
      } else {
        if (objId != null) {
          //漫画
          if (SkipTypeEnum.comic.index == skipType) {
            ComicService.instance.toComicDetail(objId);
            //小说
          } else if (SkipTypeEnum.novel.index == skipType) {
            NovelService.instance.toNovelDetail(objId);
          }
        }
      }
    }
  }
}
