import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/app/utils/str_util.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  int userId;
  @HiveField(1)
  String username;
  @HiveField(2)
  String nickname;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String email;
  @HiveField(5)
  String avatar;
  @HiveField(6)
  String description;
  @HiveField(7)
  int gender;
  @HiveField(8)
  String country;
  @HiveField(9)
  String province;
  @HiveField(10)
  String city;

  User({
    required this.userId,
    required this.username,
    required this.nickname,
    this.phone = StrUtil.empty,
    this.email = StrUtil.empty,
    this.avatar = StrUtil.empty,
    this.description = StrUtil.empty,
    required this.gender,
    this.country = StrUtil.empty,
    this.province = StrUtil.empty,
    this.city = StrUtil.empty,
  });

  factory User.empty() => User(
        userId: 0,
        username: '',
        nickname: '',
        phone: '',
        email: '',
        avatar: '',
        description: '',
        gender: 0,
        country: '',
        province: '',
        city: '',
      );

  factory User.fromJson(Map<String, dynamic> json) {
    String phone = json['phone'] ?? StrUtil.empty;
    String email = json['email'] ?? StrUtil.empty;
    String avatar = json['avatar'] ?? StrUtil.empty;
    String description = json['description'] ?? StrUtil.empty;
    String country = json['country'] ?? StrUtil.empty;
    String province = json['province'] ?? StrUtil.empty;
    String city = json['city'] ?? StrUtil.empty;
    return User(
      userId: ConvertUtil.asT<int>(json['userId'])!,
      username: ConvertUtil.asT<String>(json['username'])!,
      nickname: ConvertUtil.asT<String>(json['nickname'])!,
      phone: phone,
      email: email,
      avatar: avatar,
      description: description,
      gender: ConvertUtil.asT<int>(json['gender'])!,
      country: country,
      province: province,
      city: city,
    );
  }

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
