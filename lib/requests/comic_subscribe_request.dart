import 'package:liaz/app/http/dio_request.dart';

class ComicSubscribeRequest {
  Future<void> subscribe(int comicId, int isSubscribe) async {
    return await DioRequest.instance.post('/api/comic/subscribe', data: {
      'comicId': comicId,
      'isSubscribe': isSubscribe,
    });
  }
}
