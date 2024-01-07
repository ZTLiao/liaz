class CardItemModel {
  int cardId;
  String title;
  String cover;
  int cardType;
  String categories;
  String authors;
  String upgradeChapter;
  String? updateTime;
  int? objId;

  CardItemModel({
    required this.cardId,
    required this.title,
    required this.cover,
    required this.cardType,
    required this.categories,
    required this.authors,
    required this.upgradeChapter,
    this.updateTime,
    this.objId,
  });
}
