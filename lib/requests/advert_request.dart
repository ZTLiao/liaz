import 'package:liaz/app/http/dio_request.dart';

class AdvertRequest {
  void record(String advertType, String content) {
    DioRequest.instance.post('/api/advert/record', data: {
      'advertType': advertType,
      'content': content,
    });
  }
}
