import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/enums/grant_type_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/requests/comic_subscribe_request.dart';
import 'package:liaz/requests/novel_subscribe_request.dart';
import 'package:liaz/requests/user_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/oauth2_token_service.dart';
import 'package:path_provider/path_provider.dart';

class UserService extends GetxService {
  static UserService get instance => Get.find<UserService>();
  late Box<User> box;

  final _userRequest = UserRequest();

  final _comicSubscribeRequest = ComicSubscribeRequest();

  final _novelSubscribeRequest = NovelSubscribeRequest();

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      "User",
      path: appDir.path,
    );
  }

  Future<void> put(User user) async {
    await box.put(user.userId, user);
  }

  User? get() {
    return box.values.firstOrNull;
  }

  Future<void> getUser(userId) async {
    var user = get();
    user ??= await _userRequest.getUser(userId);
    if (user == null) {
      return;
    }
    put(user);
  }

  Future<bool> signIn(String username, String password) async {
    bool isLogin = false;
    var encryptPassword = md5.convert(utf8.encode(password)).toString();
    Log.i('password : $password, encryptPassword : $encryptPassword');
    var token = await _userRequest.signIn(
        username, encryptPassword, GrantTypeEnum.password.name);
    if (token.accessToken.isNotEmpty) {
      OAuth2TokenService.instance.put(token);
      UserService.instance.getUser(token.userId);
      EventBus.instance.publish(AppEvent.userLoginTopic);
      isLogin = true;
    }
    return isLogin;
  }

  Future<bool> signUp(String username, String password, String avatar,
      String nickname, int gender) async {
    bool isRegister = false;
    var encryptPassword = md5.convert(utf8.encode(password)).toString();
    Log.i('password : $password, encryptPassword : $encryptPassword');
    var token = await _userRequest.signUp(username, encryptPassword, avatar,
        nickname, gender, GrantTypeEnum.password.name);
    if (token.accessToken.isNotEmpty) {
      isRegister = true;
    }
    return isRegister;
  }

  void comicSubscribe(int comicId, int isSubscribe) {
    if (Global.isUserLogin) {
      _comicSubscribeRequest.subscribe(comicId, isSubscribe);
    } else {
      AppNavigator.toUserLogin();
    }
  }

  void novelSubscribe(int novelId, int isSubscribe) {
    if (Global.isUserLogin) {
      _novelSubscribeRequest.subscribe(novelId, isSubscribe);
    } else {
      AppNavigator.toUserLogin();
    }
  }

  void check() {
    if (!Global.isUserLogin) {
      AppNavigator.toUserLogin();
    }
  }
}
