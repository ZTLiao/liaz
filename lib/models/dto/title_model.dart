class TitleModel {
  int titleId;
  String title;
  int showType;
  bool isShowTitle;
  int optType;
  String? optValue;

  TitleModel({
    required this.titleId,
    required this.title,
    required this.showType,
    required this.isShowTitle,
    required this.optType,
    this.optValue,
  });
}
