import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/app/logger/log.dart';

class AdvertRequest {
  void record(String advertType, String content) {
    try {
      DioRequest.instance.post('/api/advert/record', data: {
        'advertType': advertType,
        'content': content,
      });
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
    }
  }
}
