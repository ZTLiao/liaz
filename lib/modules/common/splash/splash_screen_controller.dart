import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/file_item_service.dart';
import 'package:liaz/services/novel_service.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  RxString cover = RxString(StrUtil.empty);
  RxBool isSkip = RxBool(false);

  SplashScreenController() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: Global.appConfig.splash.duration,
      ),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void onInit() async {
    var splash = Global.appConfig.splash;
    cover.value = await FileItemService.instance.getObject(splash.cover);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!isSkip.value) {
          AppNavigator.toIndex(
            replace: true,
          );
        }
      }
    });
    _animationController.forward();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void skipPage() async {
    var splash = Global.appConfig.splash;
    var skipType = splash.skipType;
    var skipValue = splash.skipValue;
    if (skipValue.isEmpty) {
      return;
    }
    isSkip.value = true;
    if (SkipTypeEnum.h5.index == skipType) {
      await AppNavigator.toWebView(skipValue);
    } else if (SkipTypeEnum.comic.index == skipType ||
        SkipTypeEnum.novel.index == skipType) {
      if (int.parse(skipValue) != 0) {
        var objId = int.parse(skipValue);
        if (SkipTypeEnum.comic.index == skipType) {
          await ComicService.instance.toComicDetail(objId);
        } else if (SkipTypeEnum.novel.index == skipType) {
          await NovelService.instance.toNovelDetail(objId);
        }
        return;
      }
    } else {
      Map<String, dynamic> argments = <String, dynamic>{};
      if (skipValue.contains(StrUtil.question)) {
        var skipValueArray = skipValue.split(StrUtil.question);
        skipValue = skipValueArray[0];
        var argArray = skipValueArray[1].split(StrUtil.and);
        for (var arg in argArray) {
          var array = arg.split(StrUtil.equal);
          argments.putIfAbsent(array[0], () => array[1]);
        }
      }
      await AppNavigator.toContentPage(
        skipValue,
        arg: argments,
      );
    }
    AppNavigator.toIndex(
      replace: true,
    );
  }
}
