import 'package:liaz/app/controller/base_page_controller.dart';
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
    //H5
    if (SkipTypeEnum.h5.index == skipType) {
      AppNavigator.toWebView(skipValue!);
      //漫画
    } else if (SkipTypeEnum.comic.index == skipType) {
      ComicService.instance.toComicDetail(int.parse(skipValue!));
      //小说
    } else if (SkipTypeEnum.novel.index == skipType) {
      NovelService.instance.toNovelDetail(int.parse(skipValue!));
    }
  }
}
