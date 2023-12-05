import 'package:dio/dio.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/global/global.dart';

class PublicInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    var packageInfo = Global.packageInfo;
    options.headers[AppConstant.app] = packageInfo.appName;
    options.headers[AppConstant.appVersion] = packageInfo.version;
    options.headers[AppConstant.timestamp] = DateTime.now().millisecondsSinceEpoch;
    super.onRequest(options, handler);
  }
}
