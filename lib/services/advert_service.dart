import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/ads_flag.dart';
import 'package:liaz/app/constants/ads_type.dart';
import 'package:liaz/app/enums/advert_type_enum.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/requests/advert_request.dart';

class AdvertService {
  static AdvertService get instance {
    if (Get.isRegistered<AdvertService>()) {
      return Get.find<AdvertService>();
    }
    return Get.put(AdvertService());
  }

  final _advertRequest = AdvertRequest();

  void record(AdvertTypeEnum advertType, String content) {
    _advertRequest.record(advertType.name, content);
  }

  Future<void> init() async {
    try {
      var advert = Global.appConfig.advert;
      if (!advert.enabled) {
        return;
      }
      if ((advert.adsType & AdsType.csj) != 0) {
        await initRegister();
        await FlutterUnionad.getSDKVersion();
        FlutterUnionad.requestPermissionIfNecessary(
          callBack: FlutterUnionadPermissionCallBack(
            notDetermined: () {
              record(AdvertTypeEnum.notDetermined,
                  AdvertTypeEnum.notDetermined.name);
            },
            restricted: () {
              record(AdvertTypeEnum.restricted, AdvertTypeEnum.restricted.name);
            },
            denied: () {
              record(AdvertTypeEnum.denied, AdvertTypeEnum.denied.name);
            },
            authorized: () {
              record(AdvertTypeEnum.authorized, AdvertTypeEnum.authorized.name);
            },
          ),
        );
      }
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
      //全局异常捕获
      Log.logPrint(stackTrace);
    }
  }

  Future<void> initRegister() async {
    var advert = Global.appConfig.advert;
    await FlutterUnionad.register(
      //穿山甲广告 Android appid 必填
      androidAppId: advert.appId,
      //穿山甲广告 ios appid 必填
      iosAppId: advert.appId,
      //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
      useTextureView: true,
      //appname 必填
      appName: advert.appName,
      //是否允许sdk展示通知栏提示 选填
      allowShowNotify: true,
      //是否在锁屏场景支持展示广告落地页 选填
      allowShowPageWhenScreenLock: true,
      //是否显示debug日志
      debug: true,
      //是否支持多进程，true支持 选填
      supportMultiProcess: true,
      //是否开启个性化推荐 选填 默认开启
      personalise: FlutterUnionadPersonalise.close,
      //主题模式 默认FlutterUnionAdTheme.DAY,修改后需重新调用初始化
      themeStatus: FlutterUnionAdTheme.DAY,
      //允许直接下载的网络状态集合 选填
      directDownloadNetworkType: [
        FlutterUnionadNetCode.NETWORK_STATE_2G,
        FlutterUnionadNetCode.NETWORK_STATE_3G,
        FlutterUnionadNetCode.NETWORK_STATE_4G,
        FlutterUnionadNetCode.NETWORK_STATE_WIFI
      ],
    );
  }

  Widget buildBannerAdvert(
      BuildContext context, int adsFlag, int width, int height) {
    if (height == 0) {
      height = 1;
    }
    Widget advertWidget = const SizedBox();
    try {
      var advert = Global.appConfig.advert;
      if (advert.enabled) {
        if ((advert.adsType & AdsType.csj) != 0 &&
            (advert.adsFlag & adsFlag) != 0) {
          advertWidget = FlutterUnionad.bannerAdView(
            //android banner广告id 必填
            androidCodeId: advert.detailBannerCodeId,
            //ios banner广告id 必填
            iosCodeId: advert.detailBannerCodeId,
            //是否使用个性化模版
            mIsExpress: true,
            //是否支持 DeepLink 选填
            supportDeepLink: true,
            //一次请求广告数量 大于1小于3 必填
            expressAdNum: 3,
            //轮播间隔事件 30-120秒  选填
            expressTime: 30,
            // 期望view 宽度 dp 必填
            expressViewWidth: MediaQuery.of(context).size.width - width,
            //期望view高度 dp 必填
            expressViewHeight: MediaQuery.of(context).size.height / height,
            //控制下载APP前是否弹出二次确认弹窗
            downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
            //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
            adLoadType: FlutterUnionadLoadType.LOAD,
            //是否启用点击 仅ios生效 默认启用
            isUserInteractionEnabled: true,
            //广告事件回调 选填
            callBack: FlutterUnionadBannerCallBack(onShow: () {
              AdvertService.instance.record(
                  AdvertTypeEnum.bannerShow, AdvertTypeEnum.bannerShow.name);
            }, onDislike: (message) {
              AdvertService.instance
                  .record(AdvertTypeEnum.bannerDislike, message);
            }, onFail: (error) {
              AdvertService.instance
                  .record(AdvertTypeEnum.bannerFail, error.toString());
            }, onClick: () {
              AdvertService.instance.record(
                  AdvertTypeEnum.bannerClick, AdvertTypeEnum.bannerClick.name);
            }),
          );
        }
      }
    } catch (error, strace) {
      Log.e(error.toString(), strace);
    }
    return advertWidget;
  }

  Widget buildNativeAdvert(BuildContext context, int width, int height) {
    if (height == 0) {
      height = 1;
    }
    Widget advertWidget = const SizedBox();
    try {
      var advert = Global.appConfig.advert;
      if (advert.enabled) {
        if ((advert.adsType & AdsType.csj) != 0 &&
            (advert.adsFlag & AdsFlag.nativeBanner) != 0) {
          //个性化模板信息流广告
          advertWidget = Center(
            child: FlutterUnionad.nativeAdView(
              //android 信息流广告id 必填
              androidCodeId: advert.nativeCodeId,
              //ios banner广告id 必填
              iosCodeId: advert.nativeCodeId,
              //是否支持 DeepLink 选填
              supportDeepLink: true,
              // 期望view 宽度 dp 必填
              expressViewWidth: MediaQuery.of(context).size.width - width,
              //期望view高度 dp 必填
              expressViewHeight: 0,
              mIsExpress: true,
              //控制下载APP前是否弹出二次确认弹窗
              downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
              //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
              adLoadType: FlutterUnionadLoadType.LOAD,
              callBack: FlutterUnionadNativeCallBack(
                onShow: () {
                  AdvertService.instance.record(AdvertTypeEnum.nativeShow,
                      AdvertTypeEnum.nativeShow.name);
                },
                onFail: (error) {
                  AdvertService.instance
                      .record(AdvertTypeEnum.nativeFail, error.toString());
                },
                onDislike: (message) {
                  AdvertService.instance
                      .record(AdvertTypeEnum.nativeDislike, message);
                },
                onClick: () {
                  AdvertService.instance.record(AdvertTypeEnum.nativeClick,
                      AdvertTypeEnum.nativeClick.name);
                },
              ),
            ),
          );
        }
      }
    } catch (error, strace) {
      Log.e(error.toString(), strace);
    }
    return advertWidget;
  }
}
