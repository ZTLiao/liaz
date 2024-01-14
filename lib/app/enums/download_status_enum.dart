enum DownloadStatusEnum {
  /// 等待下载中
  wait,

  /// 正在读取章节信息
  loading,

  /// 下载中
  downloading,

  /// 使用数据，自动暂停，当网络切换时恢复下载
  pauseCellular,

  /// 暂停
  pause,

  /// 已完成
  complete,

  /// 读取信息时出现错误
  errorLoad,

  /// 下载出错
  error,

  /// 已取消
  cancel,

  /// 等待网络连接
  waitNetwork;
}
