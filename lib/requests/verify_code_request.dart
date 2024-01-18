import 'package:liaz/app/http/request.dart';

class VerifyCodeRequest {
  Future<void> sendVerifyCodeForEmail(String email) async {
    return await Request.instance.post(
      '/api/verify/code/email',
      data: {
        'email': email,
      },
    );
  }

  Future<bool> checkVerifyCode(String username, String verifyCode) async {
    var result = await Request.instance.post('/api/verify/code/check', data: {
      'username': username,
      'verifyCode': verifyCode,
    });
    if (result is bool) {
      return result;
    }
    return false;
  }
}
