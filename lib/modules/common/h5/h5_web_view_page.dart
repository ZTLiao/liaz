import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/modules/common/h5/h5_web_view_controller.dart';
import 'package:liaz/widgets/status/app_error_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class H5WebViewPage extends StatelessWidget {
  final String url;

  final H5WebViewController controller;

  H5WebViewPage({required this.url, super.key})
      : controller = Get.put(
          H5WebViewController(url),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
      ),
      body: Stack(
        children: [
          Obx(
            () => Offstage(
              offstage: controller.isPageLoading.value,
              child: WebViewWidget(
                controller: controller.webViewController,
              ),
            ),
          ),
          Obx(
            () => Offstage(
              offstage: !controller.isPageError.value,
              child: AppErrorWidget(
                errorMsg: controller.errorMsg.value,
                onRefresh: () => controller.webViewController.reload(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomAppBar(
            child: SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        controller.webViewController.goBack();
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        controller.webViewController.reload();
                      },
                      icon: const Icon(
                        Icons.refresh,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        controller.webViewController.goForward();
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        ShareUtil.share(
                          (await controller.webViewController.currentUrl())
                              .toString(),
                        );
                      },
                      icon: const Icon(
                        Icons.share,
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        var url =
                            await controller.webViewController.currentUrl();
                        if (url != null) {
                          launchUrlString(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(
                        Icons.open_in_browser,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 0,
            left: 0,
            child: Obx(
              () => Offstage(
                offstage: !controller.isPageLoading.value,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const LinearProgressIndicator(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
