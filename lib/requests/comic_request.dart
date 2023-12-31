import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/comic/comic_item_model.dart';
import 'package:liaz/services/app_config_service.dart';

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
        model.cover = await AppConfigService.instance.getObject(model.cover);
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
      model.cover = await AppConfigService.instance.getObject(model.cover);
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
      for (var json in result) {
        var model = ComicChapterModel.fromJson(json);
        for (int i = 0; i < model.paths.length; i++) {
          model.paths[i] =
              await AppConfigService.instance.getObject(model.paths[i]);
        }
        list.add(model);
      }
    }
    return list;
  }
}
