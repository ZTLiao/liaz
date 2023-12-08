import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class ResponseEntity {
  int code;
  String message;
  Map<String, dynamic>? data;
  int timestamp;

  ResponseEntity({
    required this.code,
    required this.message,
    this.data,
    required this.timestamp,
  });

  factory ResponseEntity.fromJson(Map<String, dynamic> json) {
    dynamic data;
    if (json['data'] != null && json['data'] != 'null') {
      data = json['data'];
    }
    return ResponseEntity(
      code: ConvertUtil.asT<int>(json['code'])!,
      message: ConvertUtil.asT<String>(json['message'])!,
      data: data,
      timestamp: ConvertUtil.asT<int>(json['timestamp'])!,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'message': message,
        'data': data,
        'timestamp': timestamp,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
