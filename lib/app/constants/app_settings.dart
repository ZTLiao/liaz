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

  /// 漫画阅读尾页显示观点/吐槽
  static final RxBool comicReaderShowViewPoint = RxBool(true);

  /// 启用旧板吐槽
  static final RxBool comicReaderOldViewPoint = RxBool(false);

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

  /// 下载漫画最大任务数
  static final RxInt downloadComicTaskCount = RxInt(5);

  /// 下载漫画最大任务数
  static final RxInt downloadNovelTaskCount = RxInt(5);

  /// 漫画搜索使用Web接口
  static final RxBool comicSearchUseWebApi = RxBool(false);

  /// 显示字体大小跟随系统
  static final RxBool useSystemFontSize = RxBool(false);

  /// 漫画阅读左手模式
  static final RxBool comicReaderLeftHandMode = RxBool(false);

  /// 小说阅读左手模式
  static final RxBool novelReaderLeftHandMode = RxBool(false);

  /// 漫画阅读优先加载高清图
  static final RxBool comicReaderHD = RxBool(false);

  /// 漫画阅读翻页动画
  static final RxBool comicReaderPageAnimation = RxBool(true);

  /// 小说阅读翻页动画
  static final RxBool novelReaderPageAnimation = RxBool(true);

  /// 下载漫画最大任务数
  static final RxInt newsFontSize = RxInt(15);

  /// 自动添加神隐漫画至收藏夹
  static final RxBool collectHideComic = RxBool(false);
}
