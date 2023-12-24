import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liaz/app/constants/bucket_constant.dart';
import 'package:liaz/app/enums/gender_enum.dart';
import 'package:liaz/app/enums/grant_type_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/requests/upload_request.dart';
import 'package:liaz/requests/user_request.dart';

class UserRegisterController extends GetxController {
  /// 图片
  Rxn<File> image = Rxn<File>();

  /// 头像
  RxString avatar = RxString(StrUtil.empty);

  /// 性别
  RxInt gender = RxInt(GenderEnum.male.index);

  /// 账号
  TextEditingController username = TextEditingController();

  /// 昵称
  TextEditingController nickname = TextEditingController();

  /// 密码
  TextEditingController password = TextEditingController();

  /// 是否显示明文
  RxBool isShowPassword = RxBool(true);

  var uploadRequest = UploadRequest();

  var userRequest = UserRequest();

  Future<void> setAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      if (image.value != null) {
        avatar.value = await uploadRequest.upload(BucketConstant.avatar, image.value!);
      }
    }
  }

  void signUp() async {
    if (password.text.isEmpty) {
      return;
    }
    var encryptPassword = md5.convert(utf8.encode(password.text)).toString();
    Log.i('password : ${password.text}, encryptPassword : $encryptPassword');
    var token = await userRequest.signUp(username.text, encryptPassword,
        avatar.value, nickname.text, gender.value, GrantTypeEnum.password.name);
    if (token.accessToken.isNotEmpty) {
      Get.back();
    }
  }
}
