import 'package:liaz/app/http/request.dart';
import 'package:liaz/models/db/oauth2_token.dart';

class OAuth2TokenRequest {
  Future<OAuth2Token?> refreshToken(String refreshToken) async {
    dynamic result = await Request.instance.post('/oauth/refresh/token', data: {
      'token': refreshToken,
    });
    if (result is Map) {
      return OAuth2Token.fromJson(result as Map<String, dynamic>);
    }
    return null;
  }
}
