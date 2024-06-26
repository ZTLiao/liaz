import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/browse/browse_history_model.dart';
import 'package:liaz/services/file_item_service.dart';

class BrowseRequest {
  void uploadHistory(int objId, int assetType, String title, String cover,
      int chapterId, String chapterName, String path, int stopIndex) {
    DioRequest.instance.post('/api/browse/history', data: {
      'objId': objId,
      'assetType': assetType,
      'title': title,
      'cover': cover,
      'chapterId': chapterId,
      'chapterName': chapterName,
      'path': path,
      'stopIndex': stopIndex,
    });
  }

  Future<List<BrowseHistoryModel>> browseRecord(
      int pageNum, int pageSize) async {
    List<BrowseHistoryModel> list = [];
    var result =
        await DioRequest.instance.get('/api/browse/record', queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result != null && result is List) {
      for (var json in result) {
        var model = BrowseHistoryModel.fromJson(json);
        model.cover = await FileItemService.instance.getObject(model.cover);
        list.add(model);
      }
    }
    return list;
  }
}
