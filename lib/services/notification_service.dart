import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/requests/notification_request.dart';

class NotificationService {
  static NotificationService get instance {
    if (Get.isRegistered<NotificationService>()) {
      return Get.find<NotificationService>();
    }
    return Get.put(NotificationService());
  }

  final _notificationRequest = NotificationRequest();

  showNotificationDialog() async {
    var notification = await _notificationRequest.getLatest();
    if (notification == null) {
      return;
    }
    var title = notification.title;
    var content = notification.content;
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return PopScope(
          child: AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: const Text(AppString.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
