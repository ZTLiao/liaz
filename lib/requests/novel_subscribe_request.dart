import 'package:liaz/app/http/request.dart';

class NovelSubscribeRequest {
  Future<void> subscribe(int novelId, int isSubscribe) async {
    return await Request.instance.post('/api/novel/subscribe', data: {
      'novelId': novelId,
      'isSubscribe': isSubscribe,
    });
  }
}
