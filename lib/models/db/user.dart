import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/convert_util.dart';

part 'user.g.dart';

@HiveField(4)
class User {
  @HiveField(0)
  int userId;
  @HiveField(1)
  String username;
  @HiveField(2)
  String nickname;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? avatar;
  @HiveField(6)
  String? description;
  @HiveField(7)
  int gender;
  @HiveField(8)
  String? country;
  @HiveField(9)
  String? province;
  @HiveField(10)
  String? city;

  User({
    required this.userId,
    required this.username,
    required this.nickname,
    this.phone,
    this.email,
    this.avatar,
    this.description,
    required this.gender,
    this.country,
    this.province,
    this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: ConvertUtil.asT<int>(json['userId'])!,
        username: ConvertUtil.asT<String>(json['username'])!,
        nickname: ConvertUtil.asT<String>(json['nickname'])!,
        phone: ConvertUtil.asT<String>(json['phone']),
        email: ConvertUtil.asT<String>(json['email']),
        avatar: ConvertUtil.asT<String>(json['avatar']),
        description: ConvertUtil.asT<String>(json['description']),
        gender: ConvertUtil.asT<int>(json['gender'])!,
        country: ConvertUtil.asT<String>(json['country']),
        province: ConvertUtil.asT<String>(json['province']),
        city: ConvertUtil.asT<String>(json['city']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'username': username,
        'nickname': nickname,
        'phone': phone,
        'email': email,
        'avatar': avatar,
        'description': description,
        'gender': gender,
        'country': country,
        'province': province,
        'city': city,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
