import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/bucket_constant.dart';
import 'package:liaz/app/enums/gender_enum.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/requests/file_request.dart';
import 'package:liaz/requests/user_request.dart';
import 'package:liaz/services/user_service.dart';

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

  var fileRequest = FileRequest();

  var userRequest = UserRequest();

  Future<void> setAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      if (image.value != null) {
        avatar.value =
            await fileRequest.upload(BucketConstant.avatar, image.value!);
      }
    }
  }

  void signUp() async {
    if (password.text.isEmpty) {
      return;
    }
    if (password.text.isNotEmpty && password.text.length < 6) {
      SmartDialog.showToast(AppString.passwordShortError);
      return;
    }
    if (!RegExp(r'[a-zA-Z0-9_-]{4,16}').hasMatch(username.text)) {
      SmartDialog.showToast(AppString.usernameInvalidError);
      return;
    }
    var isRegister = await UserService.instance.signUp(username.text,
        password.text, avatar.value, nickname.text, gender.value);
    if (isRegister) {
      Get.back();
    }
  }
}
