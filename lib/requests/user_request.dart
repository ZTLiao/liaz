import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/db/oauth2_token.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/services/app_config_service.dart';

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
    dynamic result = await Request.instance.post('/oauth/sign/in', data: {
      'username': username,
      'password': password,
      'grantType': grantType,
    });
    if (result is Map) {
      model = OAuth2Token.fromJson(result as Map<String, dynamic>);
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
    dynamic result = await Request.instance.post('/oauth/sign/up', data: {
      'username': username,
      'password': password,
      'avatar': avatar,
      'nickname': nickname,
      'gender': gender,
      'grantType': grantType,
    });
    if (result is Map) {
      model = OAuth2Token.fromJson(result as Map<String, dynamic>);
    }
    return model;
  }

  Future<User?> getUser(int userId) async {
    dynamic result =
        await Request.instance.get('/api/user/get', queryParameters: {
      'userId': userId,
    });
    if (result is Map) {
      var model = User.fromJson(result as Map<String, dynamic>);
      if (model.avatar != null) {
        model.avatar = await AppConfigService.instance.getObject(model.avatar!);
      }
      return model;
    }
    return null;
  }
}
