import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/models/novel/novel_item_model.dart';
import 'package:liaz/services/app_config_service.dart';

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
        var model = NovelItemModel.fromJson(json);
        model.cover = await AppConfigService.instance.getObject(model.cover);
        list.add(model);
      }
    }
    return list;
  }

  Future<NovelDetailModel> novelDetail(int novelId) async {
    NovelDetailModel model = NovelDetailModel.empty();
    dynamic result = await Request.instance.get('/api/novel/$novelId');
    if (result is Map) {
      model = NovelDetailModel.fromJson(result as Map<String, dynamic>);
      model.cover = await AppConfigService.instance.getObject(model.cover);
      var volumes = model.volumes;
      if (volumes.isNotEmpty) {
        for (int i = 0; i < model.volumes.length; i++) {
          var volume = model.volumes[i];
          for (int j = 0; j < volume.chapters.length; j++) {
            var chapter = volume.chapters[j];
            for (int k = 0; k < chapter.paths.length; k++) {
              chapter.paths[k] =
                  await AppConfigService.instance.getObject(chapter.paths[k]);
            }
          }
        }
      }
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
        var model = NovelChapterModel.fromJson(json);
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
