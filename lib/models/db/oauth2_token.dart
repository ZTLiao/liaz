import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/convert_util.dart';

part 'oauth2_token.g.dart';

@HiveType(typeId: 3)
class OAuth2Token {
  @HiveField(0)
  String accessToken;

  @HiveField(1)
  String tokenType;

  @HiveField(2)
  String refreshToken;

  @HiveField(3)
  int expiry;

  @HiveField(4)
  int userId;

  OAuth2Token({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiry,
    required this.userId,
  });

  factory OAuth2Token.fromJson(Map<String, dynamic> json) => OAuth2Token(
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
