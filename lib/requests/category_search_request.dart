import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/category/category_item_model.dart';
import 'package:liaz/services/file_item_service.dart';

class CategorySearchRequest {
  Future<List<CategoryItemModel>> getContent(
      int assetType, int categoryId, int pageNum, int pageSize) async {
    List<CategoryItemModel> list = [];
    dynamic result =
        await DioRequest.instance.get('/api/category/search', queryParameters: {
      'assetType': assetType,
      'categoryId': categoryId,
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
