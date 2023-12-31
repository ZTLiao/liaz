import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/services/app_config_service.dart';

class RecommendRequest {
  Future<List<RecommendModel>> recommendByPosition(int position) async {
    List<RecommendModel> list = [];
    dynamic result = await Request.instance.get('/api/recommend/$position');
    if (result is List) {
      for (var json in result) {
        var model = RecommendModel.fromJson(json);
        for (int i = 0; i < model.items.length; i++) {
          model.items[i].showValue = await AppConfigService.instance
              .getObject(model.items[i].showValue);
        }
        list.add(model);
      }
    }
    return list;
  }
}
