import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/comment/comment_item_model.dart';
import 'package:liaz/services/file_item_service.dart';

class CommentRequest {
  Future<void> discuss(
    int objId,
    int objType,
    String content,
    int resType,
    List<String> paths, {
    int parentId = 0,
  }) async {
    await DioRequest.instance.post("/api/discuss", data: {
      'objId': objId,
      'objType': objType,
      'content': content,
      'resType': resType,
      'paths': paths,
      'parentId': parentId,
    });
  }

  Future<List<CommentItemModel>> getDiscussPage(
      int objId, int objType, int pageNum, int pageSize) async {
    List<CommentItemModel> list = [];
    var result =
        await DioRequest.instance.get("/api/discuss/page", queryParameters: {
      'objId': objId,
      'objType': objType,
      'pageNum': pageNum,
      'pageSize': pageSize,
    });
    if (result != null && result is List) {
      for (var json in result) {
        var model = CommentItemModel.fromJson(json);
        model.avatar = await FileItemService.instance.getObject(model.avatar);
        for (int i = 0; i < model.paths.length; i++) {
          model.paths[i] =
              await FileItemService.instance.getObject(model.paths[i]);
        }
        var parents = model.parents;
        for (var parent in parents) {
          parent.avatar =
              await FileItemService.instance.getObject(parent.avatar);
          for (int i = 0; i < parent.paths.length; i++) {
            parent.paths[i] =
                await FileItemService.instance.getObject(parent.paths[i]);
          }
        }
        list.add(model);
      }
    }
    return list;
  }

  Future<void> thumb(int discussId) async {
    await DioRequest.instance.post("/api/discuss/thumb", data: {
      'discussId': discussId,
    });
  }
}
