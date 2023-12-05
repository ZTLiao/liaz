import 'package:dio/dio.dart';
import 'package:liaz/app/request/interceptor/public_interceptor.dart';

class Request {
  static const int _connectTimeout = 60;
  static const int _receiveTimeout = 60;
  static const int _sendTimeout = 60;

  static Request? _request;

  static Request get instance {
    _request ??= Request();
    return _request!;
  }

  late Dio dio;

  Request() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(
          seconds: _connectTimeout,
        ),
        receiveTimeout: const Duration(
          seconds: _receiveTimeout,
        ),
        sendTimeout: const Duration(
          seconds: _sendTimeout,
        ),
      ),
    );
    dio.interceptors.add(PublicInterceptor());
  }
}
