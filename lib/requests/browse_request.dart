import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/browse/browse_history_model.dart';
import 'package:liaz/services/file_service.dart';

class BrowseRequest {
  void uploadHistory(int objId, int assetType, String title, String cover,
      int chapterId, String chapterName, String path, int stopIndex) {
    Request.instance.post('/api/browse/history', data: {
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
        await Request.instance.get('/api/browse/record', queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result is List) {
      for (var json in result) {
        var model = BrowseHistoryModel.fromJson(json);
        model.cover = await FileService.instance.getObject(model.cover);
        list.add(model);
      }
    }
    return list;
  }
}
