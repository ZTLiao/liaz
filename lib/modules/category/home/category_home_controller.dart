import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';

class CategoryHomeController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  var categories = [
    AppString.all,
    AppString.comic,
    AppString.novel,
  ];

  @override
  void onInit() {
    tabController = TabController(length: categories.length, vsync: this);
    super.onInit();
  }
}
