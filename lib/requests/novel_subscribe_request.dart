import 'package:liaz/app/http/dio_request.dart';

class NovelSubscribeRequest {
  Future<void> subscribe(int novelId, int isSubscribe) async {
    return await DioRequest.instance.post('/api/novel/subscribe', data: {
      'novelId': novelId,
      'isSubscribe': isSubscribe,
    });
  }
}
