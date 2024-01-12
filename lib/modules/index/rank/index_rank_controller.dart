import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/card_item_model.dart';
import 'package:liaz/requests/rank_request.dart';

class IndexRankController extends BasePageController<CardItemModel>
    with GetTickerProviderStateMixin {
  late TabController tabController;
  var assetType = RxInt(AssetTypeEnum.comic.code);
  var timeType = RxInt(0);

  var rankRequest = RankRequest();

  var tabs = [
    AppString.popular,
    AppString.discuss,
    AppString.subscribe,
  ];

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  Future<List<CardItemModel>> getData(int currentPage, int pageSize) async {
    var tabIndex = tabController.index;
    Log.i(
        'rankType : $tabIndex, assetType : ${assetType.value}, timeType : ${timeType.value}');
    List<CardItemModel> list = [];
    var rankItems = await rankRequest.getRank(
        tabIndex, timeType.value, assetType.value, currentPage, pageSize);
    for (int i = 0; i < rankItems.length; i++) {
      var rankItem = rankItems[i];
      var types = rankItem.categories.replaceAll(StrUtil.comma, StrUtil.slash);
      var authors = rankItem.authors.replaceAll(StrUtil.comma, StrUtil.slash);
      var updateTime = DateUtil.formatDate(rankItem.updatedAt);
      var card = CardItemModel(
        cardId: rankItem.objId,
        title: rankItem.title,
        cover: rankItem.cover,
        cardType: rankItem.assetType,
        categories: types,
        authors: authors,
        upgradeChapter: rankItem.score.toString(),
        updateTime: updateTime,
      );
      list.add(card);
    }
    return list;
  }
}
