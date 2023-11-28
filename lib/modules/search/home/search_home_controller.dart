import 'package:flutter/material.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/search/search_item_model.dart';

class SearchHomeController extends BasePageController<SearchItemModel> {
  late TextEditingController searchController;

  SearchHomeController() {
    searchController = TextEditingController(text: '');
  }
}
