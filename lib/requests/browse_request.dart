import 'package:liaz/app/http/request.dart';

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
}
