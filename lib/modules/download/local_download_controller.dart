import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';

class LocalDownloadController extends BasePageController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var tabs = [
    AssetTypeEnum.comic,
    AssetTypeEnum.novel,
  ];

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }
}
