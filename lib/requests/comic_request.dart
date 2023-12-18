import 'package:liaz/app/http/request.dart';
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
}
