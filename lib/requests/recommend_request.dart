import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/services/file_item_service.dart';

class RecommendRequest {
  Future<List<RecommendModel>> recommendByPosition(int position) async {
    List<RecommendModel> list = [];
    dynamic result = await DioRequest.instance.get('/api/recommend/$position');
    if (result != null && result is List) {
      for (var json in result) {
        var model = RecommendModel.fromJson(json);
        for (int i = 0; i < model.items.length; i++) {
          model.items[i].showValue =
              await FileItemService.instance.getObject(model.items[i].showValue);
        }
        list.add(model);
      }
    }
    return list;
  }

  Future<List<RecommendModel>> recommendComic(int comicId) async {
    List<RecommendModel> list = [];
    dynamic result =
        await DioRequest.instance.get('/api/recommend/comic', queryParameters: {
      'comicId': comicId,
    });
    if (result != null && result is List) {
      for (var json in result) {
        var model = RecommendModel.fromJson(json);
        for (int i = 0; i < model.items.length; i++) {
          model.items[i].showValue =
              await FileItemService.instance.getObject(model.items[i].showValue);
        }
        list.add(model);
      }
    }
    return list;
  }

  Future<List<RecommendModel>> recommendNovel(int novelId) async {
    List<RecommendModel> list = [];
    dynamic result =
        await DioRequest.instance.get('/api/recommend/novel', queryParameters: {
      'novelId': novelId,
    });
    if (result != null && result is List) {
      for (var json in result) {
        var model = RecommendModel.fromJson(json);
        for (int i = 0; i < model.items.length; i++) {
          model.items[i].showValue =
              await FileItemService.instance.getObject(model.items[i].showValue);
        }
        list.add(model);
      }
    }
    return list;
  }
}
