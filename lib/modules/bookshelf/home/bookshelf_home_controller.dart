import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/category/category_item_model.dart';

class BookshelfHomeController extends BasePageController<List<CategoryItemModel>>
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  Future<List<List<CategoryItemModel>>> getData(int currentPage, int pageSize) {
    return Future(() => list);
  }
}
