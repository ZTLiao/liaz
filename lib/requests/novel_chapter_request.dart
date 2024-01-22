import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/services/file_service.dart';

class NovelChapterRequest {
  Future<NovelChapterModel> getNovelChapter(int novelChapterId) async {
    NovelChapterModel model = NovelChapterModel.empty();
    dynamic result =
        await Request.instance.get('/api/novel/chapter', queryParameters: {
      'novelChapterId': novelChapterId,
    });
    if (result is Map) {
      model = NovelChapterModel.fromJson(result as Map<String, dynamic>);
      for (int i = 0; i < model.paths.length; i++) {
        model.paths[i] = await FileService.instance.getObject(model.paths[i]);
      }
    }
    return model;
  }
}
