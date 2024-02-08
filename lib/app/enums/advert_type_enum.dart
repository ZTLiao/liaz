enum AdvertTypeEnum {
  /// 权限未确定
  notDetermined,

  /// 权限限制
  restricted,

  /// 权限拒绝
  denied,

  /// 权限同意
  authorized,

  /// 开屏广告显示
  splashScreenShow,

  /// 开屏广告点击
  splashScreenClick,

  /// 开屏广告失败
  splashScreenFail,

  /// 开屏广告倒计时结束
  splashScreenFinish,

  /// 开屏广告跳过
  splashScreenSkip,

  /// 开屏广告超时
  splashScreenTimeOut,

  /// banner广告加载完成
  bannerShow,

  /// banner不感兴趣
  bannerDislike,

  /// banner广告加载失败
  bannerFail,

  /// banner广告点击
  bannerClick,

  /// 信息流广告显示
  nativeShow,

  /// 信息流广告失败
  nativeFail,

  /// 信息流广告不感兴趣
  nativeDislike,

  /// 信息流广告点击
  nativeClick,

  /// 新模板渲染插屏广告显示
  screenVideoShow,

  /// 新模板渲染插屏广告跳过
  screenVideoSkip,

  /// 新模板渲染插屏广告点击
  screenVideoClick,

  /// 新模板渲染插屏广告结束
  screenVideoFinish,

  /// 新模板渲染插屏广告错误
  screenVideoFail,

  /// 新模板渲染插屏广告关闭
  screenVideoClose,

  /// 新模板渲染插屏广告预加载准备就绪
  screenVideoReady,

  /// 新模板渲染插屏广告预加载未准备就绪
  screenVideoUnReady,
  ;
}
