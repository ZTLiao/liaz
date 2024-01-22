import 'package:get/get.dart';

class AppSettings {
  /// 是否第一次运行
  static bool firstRun = false;

  /// 主题
  static final RxInt themeMode = RxInt(0);

  /// 漫画阅读方向
  /// * [0] 左右
  /// * [1] 上下
  /// * [2] 右左
  static final RxInt comicReaderDirection = RxInt(0);

  /// 漫画全屏阅读
  static final RxBool comicReaderFullScreen = RxBool(true);

  /// 漫画阅读显示状态信息
  static final RxBool comicReaderShowStatus = RxBool(true);

  /// 小说阅读方向
  /// * [0] 左右
  /// * [1] 上下
  /// * [2] 右左
  static final RxInt novelReaderDirection = RxInt(0);

  /// 小说字体
  static final RxInt novelReaderFontSize = RxInt(16);

  /// 小说行距
  static final RxDouble novelReaderLineSpacing = RxDouble(1.5);

  /// 小说阅读主题
  static final RxInt novelReaderTheme = RxInt(0);

  /// 漫画全屏阅读
  static final RxBool novelReaderFullScreen = RxBool(true);

  /// 漫画阅读显示状态信息
  static final RxBool novelReaderShowStatus = RxBool(true);

  /// 下载是否允许使用流量
  static final RxBool downloadAllowCellular = RxBool(true);

  /// 下载最大任务数
  static final RxInt downloadTaskCount = RxInt(5);

  /// 漫画阅读左手模式
  static final RxBool comicReaderLeftHandMode = RxBool(false);

  /// 小说阅读左手模式
  static final RxBool novelReaderLeftHandMode = RxBool(false);

  /// 漫画阅读翻页动画
  static final RxBool comicReaderPageAnimation = RxBool(true);

  /// 小说阅读翻页动画
  static final RxBool novelReaderPageAnimation = RxBool(true);

  /// 屏幕亮度
  static final RxDouble screenBrightness = RxDouble(0.5);

  /// 屏幕方向
  static final RxInt screenDirection = RxInt(0);
}
