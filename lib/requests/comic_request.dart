import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/comic/comic_item_model.dart';

class ComicRequest {
  Future<List<ComicItemModel>> comicUpgrade(int pageNum, int pageSize) async {
    List<ComicItemModel> list = [];
    dynamic result =
        await Request.instance.get('/api/comic/upgrade', queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result is List) {
      for (var json in result) {
        list.add(ComicItemModel.fromJson(json));
      }
    }
    return list;
  }

  Future<ComicDetailModel> comicDetail(int comicId) async {
    ComicDetailModel model = ComicDetailModel.empty();
    dynamic result = await Request.instance.get('/api/comic/$comicId');
    if (result is Map) {
      model = ComicDetailModel.fromJson(result as Map<String, dynamic>);
    }
    return model;
  }
}
