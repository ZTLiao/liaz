import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/comic/comic_item_model.dart';
import 'package:liaz/models/comic/comic_model.dart';
import 'package:liaz/services/file_service.dart';

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
        var model = ComicItemModel.fromJson(json);
        model.cover = await FileService.instance.getObject(model.cover);
        list.add(model);
      }
    }
    return list;
  }

  Future<ComicDetailModel> comicDetail(int comicId) async {
    ComicDetailModel model = ComicDetailModel.empty();
    dynamic result = await Request.instance.get('/api/comic/$comicId');
    if (result is Map) {
      model = ComicDetailModel.fromJson(result as Map<String, dynamic>);
      model.cover = await FileService.instance.getObject(model.cover);
    }
    return model;
  }

  Future<List<ComicChapterModel>> getComicCatalogue(int comicChapterId) async {
    List<ComicChapterModel> list = [];
    dynamic result =
        await Request.instance.get('/api/comic/catalogue', queryParameters: {
      'comicChapterId': comicChapterId,
    });
    if (result is List) {
      for (int i = result.length - 1; i >= 0; i--) {
        var model = ComicChapterModel.fromJson(result[i]);
        list.add(model);
      }
    }
    return list;
  }

  Future<ComicModel> getComic(int comicId) async {
    var model = ComicModel(
      comicId: 0,
      title: '',
      cover: '',
    );
    dynamic result =
        await Request.instance.get('/api/comic/get', queryParameters: {
      'comicId': comicId,
    });
    if (result is Map) {
      model = ComicModel.fromJson(result as Map<String, dynamic>);
      model.cover = await FileService.instance.getObject(model.cover);
    }
    return model;
  }
}
