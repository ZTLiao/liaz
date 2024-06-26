import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/services/file_item_service.dart';

class NovelChapterRequest {
  Future<NovelChapterModel> getNovelChapter(int novelChapterId) async {
    NovelChapterModel model = NovelChapterModel.empty();
    dynamic result =
        await DioRequest.instance.get('/api/novel/chapter', queryParameters: {
      'novelChapterId': novelChapterId,
    });
    if (result != null && result is Map) {
      model = NovelChapterModel.fromJson(result as Map<String, dynamic>);
      for (int i = 0; i < model.paths.length; i++) {
        model.paths[i] = await FileItemService.instance.getObject(model.paths[i]);
      }
    }
    return model;
  }
}
