import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/db/oauth2_token.dart';

class OAuth2TokenRequest {
  Future<OAuth2Token?> refreshToken(String refreshToken) async {
    dynamic result = await DioRequest.instance.post('/oauth/refresh/token', data: {
      'token': refreshToken,
    });
    if (result != null && result is Map) {
      var model = OAuth2Token.fromJson(result as Map<String, dynamic>);
      var accessToken = model.accessToken;
      if (accessToken.isNotEmpty) {
        Global.isUserLogin = true;
      }
      return model;
    }
    return null;
  }
}
