import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:get/get.dart';
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
}
