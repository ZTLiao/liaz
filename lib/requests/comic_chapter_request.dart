import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/services/app_config_service.dart';

class ComicChapterRequest {
  Future<ComicChapterModel> getComicChapter(int comicChapterId) async {
    ComicChapterModel model = ComicChapterModel.empty();
    dynamic result =
        await Request.instance.get('/api/comic/chapter', queryParameters: {
      'comicChapterId': comicChapterId,
    });
    if (result is Map) {
      model = ComicChapterModel.fromJson(result as Map<String, dynamic>);
      for (int i = 0; i < model.paths.length; i++) {
        model.paths[i] =
            await AppConfigService.instance.getObject(model.paths[i]);
      }
    }
    return model;
  }
}
