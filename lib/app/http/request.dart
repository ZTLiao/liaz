import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/error/app_error.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/http/response_entity.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/http/interceptor/public_interceptor.dart';

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

  /// 连接信息监听
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

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
    initConnectivity();
  }

  /// 初始化连接状态
  void initConnectivity() async {
    try {
      var connectivity = Connectivity();
      connectivitySubscription = connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        Global.netType = result.name;
      });
      ConnectivityResult result = await connectivity.checkConnectivity();
      Global.netType = result.name;
    } catch (e) {
      Log.logPrint(e);
    }
  }

  Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    String baseUrl = Global.baseUrl,
    CancelToken? cancel,
    ResponseType responseType = ResponseType.json,
  }) async {
    Map<String, dynamic> header = {};
    queryParameters ??= <String, dynamic>{};
    try {
      var response = await dio.get(
        baseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          responseType: responseType,
          headers: header,
        ),
        cancelToken: cancel,
      );
      if (response.statusCode == HttpStatus.ok) {
        var result = ResponseEntity<T>.fromJson(response.data);
        if (result.code == HttpStatus.ok) {
          return result.data;
        } else {
          throw AppError(
            result.message,
            code: result.code,
          );
        }
      }
      return response.data;
    } on DioException catch (e) {
      Log.e(e.message!, e.stackTrace);
      if (e.type == DioExceptionType.cancel) {
        rethrow;
      }
      if (e.type == DioExceptionType.badResponse) {
        return throw AppError(
            "${AppString.responseFail}${e.response?.statusCode ?? -1}");
      }
      throw AppError(AppString.serverError);
    }
  }
}
