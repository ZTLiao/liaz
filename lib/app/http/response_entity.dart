import 'package:liaz/app/utils/convert_util.dart';

class ResponseEntity<T> {
  int code;
  String message;
  T? data;
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
        'code': this.code,
        'message': this.message,
        'data': this.data,
        'timestamp': this.timestamp,
      };
}
