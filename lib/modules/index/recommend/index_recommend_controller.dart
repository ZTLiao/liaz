import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/app/enums/recommend_position_enum.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/requests/recommend_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/recommend_service.dart';

class IndexRecommendController extends BasePageController<RecommendModel> {
  var recommendRequest = RecommendRequest();

  var isFirst = true;

  @override
  Future<List<RecommendModel>> getData(int currentPage, int pageSize) async {
    List<RecommendModel> data = [];
    if (isFirst) {
      isFirst = false;
      data.addAll(await RecommendService.instance.get());
      if (data.isEmpty) {
        data = await recommendRequest
            .recommendByPosition(RecommendPositionEnum.home.index);
        RecommendService.instance.put(data);
      } else {
        recommendRequest
            .recommendByPosition(RecommendPositionEnum.home.index)
            .then((value) {
          RecommendService.instance.put(value);
          if (list.isNotEmpty) {
            for (int i = 0; i < list.length; i++) {
              var recommend = list[i];
              var where = value.where(
                  (element) => element.recommendId == recommend.recommendId);
              if (where.isNotEmpty) {
                list[i] = where.first;
              }
            }
          }
        });
      }
      return data;
    }
    data = await recommendRequest
        .recommendByPosition(RecommendPositionEnum.home.index);
    RecommendService.instance.put(data);
    return data;
  }

  void onDetail(ItemModel item) {
    RecommendService.instance.onDetail(item);
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
