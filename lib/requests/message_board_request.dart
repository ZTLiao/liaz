import 'package:liaz/app/http/request.dart';

class MessageBoardRequest {
  void welcome(String content) async {
    await Request.instance.post("/api/message/board/welcome", data: {
      'content': content,
    });
  }
}
