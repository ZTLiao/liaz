import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/category/category_model.dart';

class CategoryRequest {
  Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> list = [];
    dynamic result = await DioRequest.instance.get('/api/category');
    if (result != null && result is List) {
      for (var json in result) {
        list.add(CategoryModel.fromJson(json));
      }
    }
    return list;
  }
}
