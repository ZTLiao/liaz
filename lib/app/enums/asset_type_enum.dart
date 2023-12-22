import 'package:liaz/app/constants/app_string.dart';

enum AssetTypeEnum {
  /// 全部
  all(0, AppString.all),

  /// 漫画
  comic(1, AppString.comic),

  /// 轻小说
  novel(2, AppString.novel),
  ;

  final int code;
  final String value;

  const AssetTypeEnum(
    this.code,
    this.value,
  );
}
