import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/recommend/recommend_model.dart';

class RecommendRequest {
  Future<List<RecommendModel>> recommendByPosition(int position) async {
    List<RecommendModel> list = [];
    dynamic result = await Request.instance.get('/api/recommend/$position');
    if (result is List) {
      for (var json in result) {
        list.add(RecommendModel.fromJson(json));
      }
    }
    return list;
  }
}
