import 'package:liaz/app/http/request.dart';
import 'package:liaz/app/logger/log.dart';

class CrashRequest {
  void report(String err, StackTrace stack) async {
    try {
      var stackTrace = stack.toString();
      await Request.instance.post("/api/crash/record/report", data: {
        'err': err,
        'stackTrace': stackTrace,
      });
    } catch (error, stack) {
      Log.e(error.toString(), stack);
    }
  }
}
