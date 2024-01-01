import 'package:liaz/app/http/request.dart';

class NovelSubscribeRequest {
  void subscribe(int novelId, int isSubscribe) {
    Request.instance.post('/api/novel/subscribe', data: {
      'novelId': novelId,
      'isSubscribe': isSubscribe,
    });
  }
}
