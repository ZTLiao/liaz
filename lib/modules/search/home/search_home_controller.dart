import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/search.dart';
import 'package:liaz/models/search/search_item_model.dart';
import 'package:liaz/requests/search_request.dart';
import 'package:liaz/services/search_service.dart';

class SearchHomeController extends BasePageController<SearchItemModel> {
  late TextEditingController searchController;

  var searchKey = RxString(StrUtil.empty);

  var searchRequest = SearchRequest();

  var searchHistory = RxList<Search>([]);

  SearchHomeController() {
    searchController = TextEditingController(text: StrUtil.empty);
  }

  @override
  void onInit() {
    searchHistory.value = SearchService.instance.list();
    super.onInit();
  }

  void onSearch() {
    onSelectKey(searchController.text);
  }

  void onSelectKey(String key) {
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

  @override
  Future<List<SearchItemModel>> getData(int currentPage, int pageSize) async {
    return await searchRequest.search(searchKey.value, currentPage, pageSize);
  }
}
