import 'package:liaz/app/http/dio_request.dart';

class VerifyCodeRequest {
  Future<void> sendVerifyCodeForEmail(String email) async {
    return await DioRequest.instance.post(
      '/api/verify/code/email',
      data: {
        'email': email,
      },
    );
  }

  Future<bool> checkVerifyCode(String username, String verifyCode) async {
    var result = await DioRequest.instance.post('/api/verify/code/check', data: {
      'username': username,
      'verifyCode': verifyCode,
    });
    if (result != null && result is bool) {
      return result;
    }
    return false;
  }
}
