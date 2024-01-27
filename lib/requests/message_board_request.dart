import 'package:liaz/app/http/dio_request.dart';

class MessageBoardRequest {
  void welcome(String content) async {
    await DioRequest.instance.post("/api/message/board/welcome", data: {
      'content': content,
    });
  }
}
