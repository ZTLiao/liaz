import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/models/novel/novel_item_model.dart';
import 'package:liaz/models/novel/novel_model.dart';
import 'package:liaz/services/file_item_service.dart';

class NovelRequest {
  Future<List<NovelItemModel>> novelUpgrade(int pageNum, int pageSize) async {
    List<NovelItemModel> list = [];
    dynamic result =
        await DioRequest.instance.get('/api/novel/upgrade', queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result != null && result is List) {
      for (var json in result) {
        var model = NovelItemModel.fromJson(json);
        model.cover = await FileItemService.instance.getObject(model.cover);
        list.add(model);
      }
    }
    return list;
  }

  Future<NovelDetailModel> novelDetail(int novelId) async {
    NovelDetailModel model = NovelDetailModel.empty();
    dynamic result = await DioRequest.instance.get('/api/novel/$novelId');
    if (result is Map) {
      model = NovelDetailModel.fromJson(result as Map<String, dynamic>);
      model.cover = await FileItemService.instance.getObject(model.cover);
    }
    return model;
  }

  Future<List<NovelChapterModel>> getNovelCatalogue(int novelChapterId) async {
    List<NovelChapterModel> list = [];
    dynamic result =
        await DioRequest.instance.get('/api/novel/catalogue', queryParameters: {
      'novelChapterId': novelChapterId,
    });
    if (result is List) {
      for (int i = result.length - 1; i >= 0; i--) {
        var model = NovelChapterModel.fromJson(result[i]);
        list.add(model);
      }
    }
    return list;
  }

  Future<NovelModel> getNovel(int novelId) async {
    var model = NovelModel(
      novelId: 0,
      title: '',
      cover: '',
    );
    dynamic result =
        await DioRequest.instance.get('/api/novel/get', queryParameters: {
      'novelId': novelId,
    });
    if (result is Map) {
      model = NovelModel.fromJson(result as Map<String, dynamic>);
      model.cover = await FileItemService.instance.getObject(model.cover);
    }
    return model;
  }
}
