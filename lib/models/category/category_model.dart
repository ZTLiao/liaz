import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class CategoryModel {
  int categoryId;
  String categoryCode;
  String categoryName;
  int seqNo;

  CategoryModel({
    required this.categoryId,
    required this.categoryCode,
    required this.categoryName,
    required this.seqNo,
  });

  factory CategoryModel.empty() => CategoryModel(
        categoryId: 0,
        categoryCode: '',
        categoryName: '',
        seqNo: 0,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: ConvertUtil.asT<int>(json['categoryId'])!,
        categoryCode: ConvertUtil.asT<String>(json['categoryCode'])!,
        categoryName: ConvertUtil.asT<String>(json['categoryName'])!,
        seqNo: ConvertUtil.asT<int>(json['seqNo'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'categoryId': categoryId,
        'categoryCode': categoryCode,
        'categoryName': categoryName,
        'seqNo': seqNo,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
