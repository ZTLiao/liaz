import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class AccessTokenModel {
  String accessToken;
  String tokenType;
  String refreshToken;
  int expiry;
  int userId;

  AccessTokenModel({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiry,
    required this.userId,
  });

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) =>
      AccessTokenModel(
        accessToken: ConvertUtil.asT<String>(json['access_token'])!,
        tokenType: ConvertUtil.asT<String>(json['token_type'])!,
        refreshToken: ConvertUtil.asT<String>(json['refresh_token'])!,
        expiry: ConvertUtil.asT<int>(json['expiry'])!,
        userId: ConvertUtil.asT<int>(json['user_id'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'access_token': accessToken,
        'token_type': tokenType,
        'refresh_token': refreshToken,
        'expiry': expiry,
        'user_id': userId,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
