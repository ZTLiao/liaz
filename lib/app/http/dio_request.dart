import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/error/app_error.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/http/dio_response.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/http/interceptor/public_interceptor.dart';
import 'package:liaz/app/utils/sign_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/oauth2_token_service.dart';

class DioRequest {
  static const int _connectTimeout = 3 * 60;
  static const int _receiveTimeout = 3 * 60;
  static const int _sendTimeout = 3 * 60;

  static DioRequest? _request;

  static DioRequest get instance {
    _request ??= DioRequest();
    return _request!;
  }

  late Dio dio;

  DioRequest() {
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

  dynamic responseBody(Response<dynamic> response) {
    DioResponse? result;
    if (response.statusCode == HttpStatus.ok) {
      try {
        result = DioResponse.fromJson(response.data);
      } catch (error, stackTrace) {
        Log.e(error.toString(), stackTrace);
        SmartDialog.showToast(AppString.serverError);
        return;
      }
      if (result.code == HttpStatus.ok) {
        return result.data;
      } else {
        if (result.code == HttpStatus.unauthorized) {
          AppNavigator.toUserLogin();
          return;
        } else if (result.code == HttpStatus.forbidden) {
          SmartDialog.showToast(result.message);
          return;
        } else {
          SmartDialog.showToast(result.message);
          throw AppError(
            result.message,
            code: result.code,
          );
        }
      }
    } else {
      var data = response.data;
      result = DioResponse(
        code: HttpStatus.internalServerError,
        message: AppString.serverError,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
      if (data is Map) {
        try {
          result = DioResponse.fromJson(response.data);
        } catch (error, stackTrace) {
          Log.e(error.toString(), stackTrace);
          SmartDialog.showToast(AppString.serverError);
        }
        if (result == null) {
          SmartDialog.showToast(AppString.serverError);
          return;
        }
      }
      if (response.statusCode == HttpStatus.unauthorized) {
        AppNavigator.toUserLogin();
        return;
      } else if (response.statusCode == HttpStatus.forbidden) {
        SmartDialog.showToast(result.message);
        return;
      } else {
        throw AppError(
          result.message,
          code: result.code,
        );
      }
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancel,
    ResponseType responseType = ResponseType.json,
  }) async {
    queryParameters ??= {};
    //参数加密
    Map<String, List<String>> params = {};
    if (queryParameters.isNotEmpty) {
      queryParameters.forEach((key, value) {
        if (value is List) {
          params.putIfAbsent(
              key, () => value.map((e) => e.toString()).toList());
        } else {
          params.putIfAbsent(key, () => [value.toString()]);
        }
      });
    }
    //时间戳
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    //请求头
    Map<String, dynamic> header = {};
    header[AppConstant.timestamp] = timestamp;
    //加签
    header[AppConstant.sign] =
        SignUtil.generateSign(params, timestamp, Global.signKey);
    //添加token
    var oauth2Token = await OAuth2TokenService.instance.get();
    if (oauth2Token != null) {
      header[AppConstant.authorization] =
          oauth2Token.tokenType + StrUtil.space + oauth2Token.accessToken;
      header[AppConstant.userId] = oauth2Token.userId;
    }
    try {
      var response = await dio.get(
        Global.baseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          responseType: responseType,
          headers: header,
        ),
        cancelToken: cancel,
      );
      return responseBody(response);
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

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    CancelToken? cancel,
  }) async {
    queryParameters ??= {};
    data ??= {};
    //参数加密
    Map<String, List<String>> params = {};
    if (queryParameters.isNotEmpty) {
      queryParameters.forEach((key, value) {
        if (value is List) {
          params.putIfAbsent(
              key, () => value.map((e) => e.toString()).toList());
        } else {
          params.putIfAbsent(key, () => [value.toString()]);
        }
      });
    }
    if (data.isNotEmpty) {
      data.forEach((key, value) {
        if (value is List) {
          params.putIfAbsent(
              key, () => value.map((e) => e.toString()).toList());
        } else {
          params.putIfAbsent(key, () => [value.toString()]);
        }
      });
    }
    //时间戳
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    //请求头
    Map<String, dynamic> header = {};
    header[AppConstant.timestamp] = timestamp;
    //加签
    header[AppConstant.sign] =
        SignUtil.generateSign(params, timestamp, Global.signKey);
    //添加token
    var oauth2Token = await OAuth2TokenService.instance.get();
    if (oauth2Token != null) {
      header[AppConstant.authorization] =
          oauth2Token.tokenType + StrUtil.space + oauth2Token.accessToken;
      header[AppConstant.userId] = oauth2Token.userId;
    }
    try {
      var response = await dio.post(
        Global.baseUrl + path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          headers: header,
          contentType: Headers.formUrlEncodedContentType,
        ),
        cancelToken: cancel,
      );
      return responseBody(response);
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

  Future<dynamic> uploadFile(
    String path,
    File file, {
    Map<String, dynamic>? data,
    CancelToken? cancel,
  }) async {
    data ??= {};
    //参数加密
    Map<String, List<String>> params = {};
    if (data.isNotEmpty) {
      data.forEach((key, value) {
        if (value is List) {
          params.putIfAbsent(
              key, () => value.map((e) => e.toString()).toList());
        } else {
          params.putIfAbsent(key, () => [value.toString()]);
        }
      });
    }
    data['file'] = await MultipartFile.fromFile(file.path,
        filename: file.path.split(StrUtil.slash).last);
    //时间戳
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    //请求头
    Map<String, dynamic> header = {};
    header[AppConstant.timestamp] = timestamp;
    //加签
    header[AppConstant.sign] =
        SignUtil.generateSign(params, timestamp, Global.signKey);
    //添加token
    var oauth2Token = await OAuth2TokenService.instance.get();
    if (oauth2Token != null) {
      header[AppConstant.authorization] =
          oauth2Token.tokenType + StrUtil.space + oauth2Token.accessToken;
      header[AppConstant.userId] = oauth2Token.userId;
    }
    try {
      var response = await dio.post(
        Global.baseUrl + path,
        data: FormData.fromMap(data),
        options: Options(
          responseType: ResponseType.json,
          headers: header,
          contentType: Headers.multipartFormDataContentType,
        ),
        cancelToken: cancel,
      );
      return responseBody(response);
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

  Future<dynamic> getResource(
    String url, {
    ResponseType responseType = ResponseType.plain,
    CancelToken? cancel,
  }) async {
    try {
      var response = await dio.get(
        url,
        cancelToken: cancel,
        options: Options(
          responseType: responseType,
        ),
      );
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
