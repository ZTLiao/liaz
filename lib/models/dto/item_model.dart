class ItemModel {
  int itemId;
  String title;
  String? subTitle;
  String showValue;
  int skipType;
  String? skipValue;
  int? objId;

  ItemModel({
    required this.itemId,
    required this.title,
    this.subTitle,
    required this.showValue,
    required this.skipType,
    this.skipValue,
    this.objId,
  });
}
