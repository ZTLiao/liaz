import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/models/notification/notification_model.dart';

class NotificationRequest {
  Future<NotificationModel?> getLatest() async {
    var result = await DioRequest.instance.get("/api/notification/latest");
    if (result != null && result is Map) {
      return NotificationModel.fromJson(result as Map<String, dynamic>);
    }
    return null;
  }
}
