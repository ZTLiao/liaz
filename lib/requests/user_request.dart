import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/oauth/access_token_model.dart';

class UserRequest {
  Future<AccessTokenModel> signIn(
      String username, String password, String grantType) async {
    var model = AccessTokenModel(
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
      model = AccessTokenModel.fromJson(result as Map<String, dynamic>);
    }
    return model;
  }

  Future<AccessTokenModel> signUp(String username, String password,
      String nickname, int gender, String grantType) async {
    var model = AccessTokenModel(
      accessToken: '',
      tokenType: '',
      refreshToken: '',
      expiry: 0,
      userId: 0,
    );
    dynamic result = await Request.instance.post('/oauth/sign/up', data: {
      'username': username,
      'password': password,
      'nickname': nickname,
      'gender': gender,
      'grantType': grantType,
    });
    if (result is Map) {
      model = AccessTokenModel.fromJson(result as Map<String, dynamic>);
    }
    return model;
  }
}
