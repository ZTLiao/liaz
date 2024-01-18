import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/http/request.dart';

class VerifyCodeRequest {
  Future<void> sendVerifyCodeForEmail(String email) async {
    await Request.instance.post(
      '/api/verify/code/email',
      data: {
        'email': email,
      },
    );
    SmartDialog.showToast(AppString.sendSuccess);
  }
}
