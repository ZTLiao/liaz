import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/comment/comment_item_model.dart';
import 'package:liaz/requests/comment_request.dart';

class CommentListController extends BasePageController<CommentItemModel> {
  final int objId;
  final int objType;

  final commentRequest = CommentRequest();

  CommentListController(this.objId, this.objType);

  @override
  Future<List<CommentItemModel>> getData(int currentPage, int pageSize) async {
    return await commentRequest.getDiscussPage(
        objId, objType, currentPage, pageSize);
  }
}
