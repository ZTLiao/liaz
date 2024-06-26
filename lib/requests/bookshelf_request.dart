import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/category/category_item_model.dart';
import 'package:liaz/services/file_item_service.dart';

class BookshelfRequest {
  Future<List<CategoryItemModel>> getComic(
      int sortType, int pageNum, int pageSize) async {
    List<CategoryItemModel> list = <CategoryItemModel>[];
    dynamic result =
        await DioRequest.instance.get('/api/bookshelf/comic', queryParameters: {
      'sortType': sortType,
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result != null && result is List) {
      for (var json in result) {
        var model = CategoryItemModel.fromJson(json);
        model.cover = await FileItemService.instance.getObject(model.cover);
        list.add(model);
      }
    }
    return list;
  }

  Future<List<CategoryItemModel>> getNovel(
      int sortType, int pageNum, int pageSize) async {
    List<CategoryItemModel> list = <CategoryItemModel>[];
    dynamic result =
        await DioRequest.instance.get('/api/bookshelf/novel', queryParameters: {
      'sortType': sortType,
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result != null && result is List) {
      for (var json in result) {
        var model = CategoryItemModel.fromJson(json);
        model.cover = await FileItemService.instance.getObject(model.cover);
        list.add(model);
      }
    }
    return list;
  }
}
