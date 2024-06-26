import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/db/oauth2_token.dart';
import 'package:liaz/models/db/user.dart';

class UserRequest {
  Future<OAuth2Token> signIn(
      String username, String password, String grantType) async {
    var model = OAuth2Token(
      accessToken: '',
      tokenType: '',
      refreshToken: '',
      expiry: 0,
      userId: 0,
    );
    dynamic result = await DioRequest.instance.post('/oauth/sign/in', data: {
      'username': username,
      'password': password,
      'grantType': grantType,
    });
    if (result != null && result is Map) {
      model = OAuth2Token.fromJson(result as Map<String, dynamic>);
      var accessToken = model.accessToken;
      if (accessToken.isNotEmpty) {
        Global.isUserLogin = true;
      }
    }
    return model;
  }

  Future<OAuth2Token> signUp(String username, String password, String avatar,
      String nickname, int gender, String grantType) async {
    var model = OAuth2Token(
      accessToken: '',
      tokenType: '',
      refreshToken: '',
      expiry: 0,
      userId: 0,
    );
    dynamic result = await DioRequest.instance.post('/oauth/sign/up', data: {
      'username': username,
      'password': password,
      'avatar': avatar,
      'nickname': nickname,
      'gender': gender,
      'grantType': grantType,
    });
    if (result != null && result is Map) {
      model = OAuth2Token.fromJson(result as Map<String, dynamic>);
    }
    return model;
  }

  Future<User?> getUser(int userId) async {
    dynamic result =
        await DioRequest.instance.get('/api/user/get', queryParameters: {
      'userId': userId,
    });
    if (result != null && result is Map) {
      return User.fromJson(result as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> resetPassword(
      String username, String verifyCode, String newPassword) async {
    return await DioRequest.instance.post('/api/account/reset/password', data: {
      'username': username,
      'verifyCode': verifyCode,
      'newPassword': newPassword,
    });
  }

  Future<User> updateUser(int userId, String avatar, String nickname,
      String phone, String email, int gender, String description) async {
    var user = User.empty();
    var result = await DioRequest.instance.post('/api/user/update', data: {
      'userId': userId,
      'avatar': avatar,
      'nickname': nickname,
      'phone': phone,
      'email': email,
      'gender': gender,
      'description': description,
    });
    if (result != null && result is Map) {
      user = User.fromJson(result as Map<String, dynamic>);
    }
    return user;
  }

  Future<void> signOut() async {
    return await DioRequest.instance.post("/oauth/sign/out");
  }

  Future<void> setPassword(String password) async {
    return await DioRequest.instance.post("/api/account/set/password", data: {
      'password': password,
    });
  }
}
