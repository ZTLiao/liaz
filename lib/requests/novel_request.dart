import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/models/novel/novel_item_model.dart';

class NovelRequest {
  Future<List<NovelItemModel>> novelUpgrade(int pageNum, int pageSize) async {
    List<NovelItemModel> list = [];
    dynamic result =
        await Request.instance.get('/api/novel/upgrade', queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result is List) {
      for (var json in result) {
        list.add(NovelItemModel.fromJson(json));
      }
    }
    return list;
  }

  Future<NovelDetailModel> novelDetail(int novelId) async {
    NovelDetailModel model = NovelDetailModel.empty();
    dynamic result = await Request.instance.get('/api/novel/$novelId');
    if (result is Map) {
      model = NovelDetailModel.fromJson(result as Map<String, dynamic>);
    }
    return model;
  }

  Future<List<NovelChapterModel>> getNovelCatalogue(int novelChapterId) async {
    List<NovelChapterModel> list = [];
    dynamic result =
        await Request.instance.get('/api/novel/catalogue', queryParameters: {
      'novelChapterId': novelChapterId,
    });
    if (result is List) {
      for (var json in result) {
        list.add(NovelChapterModel.fromJson(json));
      }
    }
    return list;
  }
}
