import 'package:liaz/app/http/request.dart';

class ComicSubscribeRequest {
  void subscribe(int comicId, int isSubscribe) {
    Request.instance.post('/api/comic/subscribe', data: {
      'comicId': comicId,
      'isSubscribe': isSubscribe,
    });
  }
}
