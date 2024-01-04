import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/services/device_info_service.dart';

class PublicInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      var connectivity = Connectivity();
      ConnectivityResult result = await connectivity.checkConnectivity();
      Global.netType = result.name;
      options.extra['ts'] = DateTime.now().millisecondsSinceEpoch;
      var packageInfo = Global.packageInfo;
      var deviceInfo = DeviceInfoService.instance.get();
      options.headers[AppConstant.app] = packageInfo.appName;
      options.headers[AppConstant.appVersion] = packageInfo.version;
      options.headers[AppConstant.deviceId] = deviceInfo.deviceId;
      options.headers[AppConstant.os] = deviceInfo.os;
      options.headers[AppConstant.osVersion] = deviceInfo.osVersion;
      options.headers[AppConstant.netType] = Global.netType;
      options.headers[AppConstant.model] = deviceInfo.model;
      options.headers[AppConstant.imei] = deviceInfo.imei;
      options.headers[AppConstant.client] = deviceInfo.os;
      options.headers[AppConstant.channel] = AppConstant.channelName;
    } catch (e) {
      Log.logPrint(e);
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var time =
        DateTime.now().millisecondsSinceEpoch - err.requestOptions.extra['ts'];
    Log.e('''http request runtime:${time}ms
Request Method：${err.requestOptions.method}
Response Code：${err.response?.statusCode}
Request URL：${err.requestOptions.uri}
Request Query：${err.requestOptions.queryParameters}
Request Data：${err.requestOptions.data}
Request Headers：${err.requestOptions.headers}
Response Headers：${err.response?.headers.map}
Response Data：${err.response?.data}''', err.stackTrace ?? StackTrace.current);
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var time = DateTime.now().millisecondsSinceEpoch -
        response.requestOptions.extra['ts'];
    Log.d(
      '''http response runtime:${time}ms
Request Method：${response.requestOptions.method}
Request Code：${response.statusCode}
Request URL：${response.requestOptions.uri}
Request Query：${response.requestOptions.queryParameters}
Request Data：${response.requestOptions.data}
Request Headers：${response.requestOptions.headers}
Response Headers：${response.headers.map}
Response Data：${response.data}''',
    );
    super.onResponse(response, handler);
  }
}
