import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/version/app_version_model.dart';

class AppVersionRequest {
  Future<AppVersionModel?> checkUpdate() async {
    var result = await DioRequest.instance.get("/api/app/version/check/update");
    if (result != null && result is Map) {
      return AppVersionModel.fromJson(result as Map<String, dynamic>);
    }
    return null;
  }
}
