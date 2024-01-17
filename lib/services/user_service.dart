import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/enums/grant_type_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/requests/comic_subscribe_request.dart';
import 'package:liaz/requests/novel_subscribe_request.dart';
import 'package:liaz/requests/oauth2_token_request.dart';
import 'package:liaz/requests/user_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/oauth2_token_service.dart';
import 'package:path_provider/path_provider.dart';

class UserService extends GetxService {
  static UserService get instance => Get.find<UserService>();
  Box<User>? box;

  final _oauth2TokenRequest = OAuth2TokenRequest();

  final _userRequest = UserRequest();

  final _comicSubscribeRequest = ComicSubscribeRequest();

  final _novelSubscribeRequest = NovelSubscribeRequest();

  Future<void> init() async {
    if (box == null) {
      var appDir = await getApplicationSupportDirectory();
      box = await Hive.openBox(
        Db.user,
        path: appDir.path,
      );
    }
  }

  Future<void> refreshToken() async {
    Global.isUserLogin = false;
    var oauth2Token = await OAuth2TokenService.instance.get();
    if (oauth2Token != null) {
      _oauth2TokenRequest.refreshToken(oauth2Token.refreshToken).then((value) {
        if (value != null) {
          OAuth2TokenService.instance.put(value);
        } else {
          clear();
        }
      });
    }
  }

  Future<void> put(User user) async {
    await box!.put(user.userId, user);
  }

  Future<User?> get() async {
    await init();
    return box!.values.firstOrNull;
  }

  Future<User?> getUser(userId) async {
    var user = await get();
    user ??= await _userRequest.getUser(userId);
    if (user == null) {
      return null;
    }
    put(user);
    return user;
  }

  void clear() async {
    var keys = box!.values.toList().map((e) => e.userId).toList();
    if (keys.isNotEmpty) {
      box!.deleteAll(keys);
    }
  }

  Future<bool> signIn(String username, String password) async {
    bool isLogin = false;
    var encryptPassword = md5.convert(utf8.encode(password)).toString();
    Log.i('password : $password, encryptPassword : $encryptPassword');
    var token = await _userRequest.signIn(
        username, encryptPassword, GrantTypeEnum.password.name);
    if (token.accessToken.isNotEmpty) {
      OAuth2TokenService.instance.put(token);
      await UserService.instance.getUser(token.userId);
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
      _comicSubscribeRequest.subscribe(comicId, isSubscribe).then(
          (value) => EventBus.instance.publish(AppEvent.kSubscribeComicTopic));
    } else {
      AppNavigator.toUserLogin();
    }
  }

  void novelSubscribe(int novelId, int isSubscribe) {
    if (Global.isUserLogin) {
      _novelSubscribeRequest.subscribe(novelId, isSubscribe).then(
          (value) => EventBus.instance.publish(AppEvent.kSubscribeNovelTopic));
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
