import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/app/enums/recommend_position_enum.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/requests/recommend_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/novel_service.dart';

class IndexRecommendController extends BasePageController<RecommendModel> {
  var recommendRequest = RecommendRequest();

  @override
  Future<List<RecommendModel>> getData(int currentPage, int pageSize) async {
    return await recommendRequest
        .recommendByPosition(RecommendPositionEnum.home.index);
  }

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

  void onOperate(int recommendType, int optType, String? optValue) async {
    if (optType == OptTypeEnum.refresh.index) {
      var data = await getData(1, pageSize);
      if (data.isNotEmpty) {
        var recommend = data
            .where((element) => element.recommendType == recommendType)
            .firstOrNull;
        if (recommend == null) {
          return;
        }
        for (var value in list) {
          if (value.recommendType == recommendType) {
            value.items = recommend.items;
            break;
          }
        }
      }
    } else {
      if (optValue != null) {
        AppNavigator.toContentPage(optValue);
      }
    }
  }
}
