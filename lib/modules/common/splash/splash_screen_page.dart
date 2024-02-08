import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/ads_flag.dart';
import 'package:liaz/app/constants/ads_type.dart';
import 'package:liaz/app/enums/advert_type_enum.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/modules/common/splash/splash_screen_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/advert_service.dart';

class SplashScreenPage extends StatelessWidget {
  final SplashScreenController controller;

  SplashScreenPage({super.key})
      : controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    var splash = Global.appConfig.splash;
    var advert = Global.appConfig.advert;
    Widget splashWidget = const SizedBox();
    if (splash.cover.isNotEmpty) {
      splashWidget = FadeTransition(
        opacity: controller.animation,
        child: Obx(
          () => InkWell(
            onTap: controller.skipPage,
            child: ExtendedImage.network(
              controller.cover.value,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      );
    } else if (advert.enabled) {
      if ((advert.adsType & AdsType.csj) != 0 &&
          (advert.adsFlag & AdsFlag.splash) != 0) {
        splashWidget = FlutterUnionad.splashAdView(
          //是否使用个性化模版  设定widget宽高
          mIsExpress: true,
          //android 开屏广告广告id 必填
          androidCodeId: advert.splashCodeId,
          //ios 开屏广告广告id 必填
          iosCodeId: advert.splashCodeId,
          //是否支持 DeepLink 选填
          supportDeepLink: true,
          // 期望view 宽度 dp 选填 mIsExpress=true必填
          expressViewWidth: MediaQuery.of(context).size.width,
          //期望view高度 dp 选填 mIsExpress=true必填
          expressViewHeight: MediaQuery.of(context).size.height,
          //控制下载APP前是否弹出二次确认弹窗
          downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
          //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
          adLoadType: FlutterUnionadLoadType.LOAD,
          //是否影藏跳过按钮(当影藏的时候显示自定义跳过按钮) 默认显示
          hideSkip: false,
          callBack: FlutterUnionadSplashCallBack(
            onShow: () {
              AdvertService.instance.record(AdvertTypeEnum.splashScreenShow,
                  AdvertTypeEnum.splashScreenShow.name);
            },
            onClick: () {
              AdvertService.instance.record(AdvertTypeEnum.splashScreenClick,
                  AdvertTypeEnum.splashScreenClick.name);
              AppNavigator.closePage();
            },
            onFail: (error) {
              AdvertService.instance
                  .record(AdvertTypeEnum.splashScreenFail, error.toString());
            },
            onFinish: () {
              AdvertService.instance.record(AdvertTypeEnum.splashScreenFinish,
                  AdvertTypeEnum.splashScreenFinish.name);
              AppNavigator.closePage();
            },
            onSkip: () {
              AdvertService.instance.record(AdvertTypeEnum.splashScreenSkip,
                  AdvertTypeEnum.splashScreenSkip.name);
              AppNavigator.closePage();
            },
            onTimeOut: () {
              AdvertService.instance.record(AdvertTypeEnum.splashScreenTimeOut,
                  AdvertTypeEnum.splashScreenTimeOut.name);
            },
          ),
        );
      }
    }
    return splashWidget;
  }
}
