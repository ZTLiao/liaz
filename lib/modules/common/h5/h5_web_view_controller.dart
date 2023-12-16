import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class H5WebViewController extends BaseController {
  final String url;

  H5WebViewController(this.url);

  final WebViewController webViewController = WebViewController();

  var title = RxString(AppString.loading);

  @override
  void onInit() async {
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(
        Get.isDarkMode ? Colors.black : AppColor.backgroundColor);
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          isPageLoading.value = true;
        },
        onPageFinished: (String url) async {
          isPageLoading.value = false;
          title.value =
              (await webViewController.getTitle()) ?? StrUtil.empty;
        },
        onNavigationRequest: (NavigationRequest request) {
          var uri = Uri.parse(request.url);
          Log.d(request.url);
          if (uri.scheme == AppConstant.https ||
              uri.scheme == AppConstant.http) {
            return NavigationDecision.navigate;
          }
          return NavigationDecision.prevent;
        },
      ),
    );
    webViewController.loadRequest(Uri.parse(url), headers: {
      //TODO
    });
    super.onInit();
  }
}
