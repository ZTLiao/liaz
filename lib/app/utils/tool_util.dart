import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:path/path.dart' as path;

class ToolUtil {
  /// 复制文本
  static void copyText(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      SmartDialog.showToast(AppString.alreadyCopeid);
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  static void showImageViewer(int initIndex, List<String> images) {
    var index = RxInt(initIndex);
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: images.length,
              builder: (_, i) {
                if (images[i].startsWith(AppConstant.http) ||
                    images[i].startsWith(AppConstant.https)) {
                  return PhotoViewGalleryPageOptions(
                    filterQuality: FilterQuality.high,
                    imageProvider: ExtendedNetworkImageProvider(
                      images[i],
                      cache: true,
                    ),
                    onTapUp: ((context, details, controllerValue) =>
                        Get.back()),
                  );
                } else {
                  return PhotoViewGalleryPageOptions(
                    filterQuality: FilterQuality.high,
                    imageProvider: ExtendedMemoryImageProvider(
                      File(images[i]).readAsBytesSync(),
                    ),
                    onTapUp: ((context, details, controllerValue) =>
                        Get.back()),
                  );
                }
              },
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(),
              ),
              pageController: PageController(
                initialPage: index.value,
              ),
              onPageChanged: ((i) {
                index.value = i;
              }),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: AppStyle.edgeInsetsA24
                  .copyWith(bottom: 24 + AppStyle.bottomBarHeight),
              child: Obx(
                () => Text(
                  '${index.value + 1}/${images.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              right: 12 + AppStyle.bottomBarHeight,
              bottom: 12,
              child: TextButton.icon(
                onPressed: () {
                  saveImage(images[index.value]);
                },
                icon: const Icon(Icons.save),
                label: const Text(AppString.save),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 检查相册权限
  static Future<bool> checkPhotoPermission() async {
    try {
      var status = await Permission.photos.status;
      if (status == PermissionStatus.granted) {
        return true;
      }
      status = await Permission.photos.request();
      if (status.isGranted) {
        return true;
      } else {
        SmartDialog.showToast(AppString.pleasePhotoPermission);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// 保存图片
  static void saveImage(String url) async {
    if (Platform.isIOS && !await checkPhotoPermission()) {
      return;
    }
    try {
      Uint8List? data;
      if (url.startsWith(AppConstant.http) ||
          url.startsWith(AppConstant.https)) {
        var provider = ExtendedNetworkImageProvider(url, cache: true);
        data = await provider.getNetworkImageData();
      } else {
        data = await File(url).readAsBytes();
      }

      if (data == null) {
        SmartDialog.showToast(AppString.photoSaveFail);
        return;
      }
      var cacheDir = await getTemporaryDirectory();
      var file = File(path.join(cacheDir.path, path.basename(url)));
      await file.writeAsBytes(data);
      final result = await ImageGallerySaver.saveFile(
        file.path,
        name: path.basename(url),
        isReturnPathOfIOS: true,
      );
      Log.d(result.toString());
      SmartDialog.showToast(AppString.saveSuccess);
    } catch (e) {
      SmartDialog.showToast(AppString.saveError);
    }
  }

  static String toResource(String uri) {
    if (uri.startsWith(AppConstant.https) || uri.startsWith(AppConstant.http)) {
      return uri;
    } else {
      return Global.appConfig.fileUrl + uri;
    }
  }
}
