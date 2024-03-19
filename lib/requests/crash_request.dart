import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/app/logger/log.dart';

class CrashRequest {
  void report(String err, StackTrace stack) async {
    try {
      var stackTrace = stack.toString();
      await DioRequest.instance.post("/api/crash/record/report", data: {
        'err': err,
        'stackTrace': stackTrace,
      });
    } catch (error, stack) {
      Log.logPrint(stack);
    }
  }
}
