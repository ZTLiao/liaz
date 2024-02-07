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
  ;
}
