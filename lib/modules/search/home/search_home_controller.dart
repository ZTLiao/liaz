import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/search.dart';
import 'package:liaz/models/dto/card_item_model.dart';
import 'package:liaz/models/search/search_item_model.dart';
import 'package:liaz/requests/search_request.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/novel_service.dart';
import 'package:liaz/services/search_service.dart';

class SearchHomeController extends BasePageController<SearchItemModel> {
  late TextEditingController searchController;

  var searchKey = RxString(StrUtil.empty);

  var searchRequest = SearchRequest();

  var searchHistory = RxList<Search>([]);

  var hotRank = RxList<SearchItemModel>([]);

  SearchHomeController() {
    searchController = TextEditingController(text: StrUtil.empty);
  }

  @override
  void onInit() {
    searchHistory.value = SearchService.instance.list();
    searchRequest.hotRank().then((value) => hotRank.value = value);
    super.onInit();
  }

  @override
  Future<List<SearchItemModel>> getData(int currentPage, int pageSize) async {
    return await searchRequest.search(searchKey.value, currentPage, pageSize);
  }

  void onSearch() {
    onSelectKey(searchController.text);
  }

  void onSelectKey(String key) {
    list.clear();
    if (key.isEmpty) {
      return;
    }
    searchKey.value = key;
    searchController.text = key;
    SearchService.instance.put(
      Search(
        key: key,
      ),
    );
    searchHistory.value = SearchService.instance.list();
    onRefresh();
  }

  void clear() {
    SearchService.instance.clear();
    searchHistory.clear();
  }

  void onDetail(CardItemModel card) {
    var cardType = card.cardType;
    if (cardType == AssetTypeEnum.comic.index) {
      ComicService.instance.toComicDetail(card.cardId);
    } else if (cardType == AssetTypeEnum.novel.index) {
      NovelService.instance.toNovelDetail(card.cardId);
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchController.clear();
  }
}
