import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/services/file_item_service.dart';

class ComicChapterRequest {
  Future<ComicChapterModel> getComicChapter(int comicChapterId) async {
    ComicChapterModel model = ComicChapterModel.empty();
    dynamic result =
        await DioRequest.instance.get('/api/comic/chapter', queryParameters: {
      'comicChapterId': comicChapterId,
    });
    if (result != null && result is Map) {
      model = ComicChapterModel.fromJson(result as Map<String, dynamic>);
      for (int i = 0; i < model.paths.length; i++) {
        model.paths[i] = await FileItemService.instance.getObject(model.paths[i]);
      }
    }
    return model;
  }
}
