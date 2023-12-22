import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/category/category_item_model.dart';

class CategorySearchRequest {
  Future<List<CategoryItemModel>> getContent(
      int assetType, int categoryId, int pageNum, int pageSize) async {
    List<CategoryItemModel> list = [];
    dynamic result =
        await Request.instance.get('/api/category/search', queryParameters: {
      'assetType': assetType,
      'categoryId': categoryId,
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result is List) {
      for (var json in result) {
        list.add(CategoryItemModel.fromJson(json));
      }
    }
    return list;
  }
}
