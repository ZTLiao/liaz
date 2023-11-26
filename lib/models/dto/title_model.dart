class TitleModel {
  int titleId;
  String title;
  int showType;
  int showTitle;
  int optType;
  String? optValue;

  TitleModel({
    required this.titleId,
    required this.title,
    required this.showType,
    required this.showTitle,
    required this.optType,
    this.optValue,
  });
}
