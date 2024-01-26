import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/rank/rank_item_model.dart';
import 'package:liaz/services/file_item_service.dart';

class RankRequest {
  Future<List<RankItemModel>> getRank(int rankType, int timeType, int assetType,
      int pageNum, int pageSize) async {
    List<RankItemModel> list = [];
    var result = await Request.instance.get("/api/rank", queryParameters: {
      'rankType': rankType,
      'timeType': timeType,
      'assetType': assetType,
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result != null && result is List) {
      for (var json in result) {
        var model = RankItemModel.fromJson(json);
        model.cover = await FileItemService.instance.getObject(model.cover);
        list.add(model);
      }
    }
    return list;
  }
}
