import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/search/search_item_model.dart';
import 'package:liaz/services/app_config_service.dart';

class SearchRequest {
  Future<List<SearchItemModel>> search(
      String key, int pageNum, int pageSize) async {
    List<SearchItemModel> list = [];
    dynamic result =
        await Request.instance.get('/api/search', queryParameters: {
      'key': key,
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result is List) {
      for (var json in result) {
        var model = SearchItemModel.fromJson(json);
        model.cover = await AppConfigService.instance.getObject(model.cover);
        list.add(model);
      }
    }
    return list;
  }

  Future<List<SearchItemModel>> hotRank() async {
    List<SearchItemModel> list = [];
    dynamic result = await Request.instance.get('/api/search/hot/rank');
    if (result is List) {
      for (var json in result) {
        list.add(SearchItemModel.fromJson(json));
      }
    }
    return list;
  }
}
