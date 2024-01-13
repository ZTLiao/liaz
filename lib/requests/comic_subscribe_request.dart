import 'package:liaz/app/http/request.dart';

class ComicSubscribeRequest {
  Future<void> subscribe(int comicId, int isSubscribe) async {
    return await Request.instance.post('/api/comic/subscribe', data: {
      'comicId': comicId,
      'isSubscribe': isSubscribe,
    });
  }
}
