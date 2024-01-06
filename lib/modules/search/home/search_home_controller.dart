import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/search/search_item_model.dart';
import 'package:liaz/requests/search_request.dart';

class SearchHomeController extends BasePageController<SearchItemModel> {
  late TextEditingController searchController;

  var searchKey = RxString(StrUtil.empty);

  var searchRequest = SearchRequest();

  SearchHomeController() {
    searchController = TextEditingController(text: StrUtil.empty);
  }

  void onSearch() {
    searchKey.value = searchController.text;
    onRefresh();
  }

  @override
  Future<List<SearchItemModel>> getData(int currentPage, int pageSize) async {
    return await searchRequest.search(searchKey.value, currentPage, pageSize);
  }
}
