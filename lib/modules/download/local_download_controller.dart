import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/models/category/category_item_model.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/novel_service.dart';

class LocalDownloadController
    extends BasePageController<List<CategoryItemModel>>
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

  @override
  Future<List<List<CategoryItemModel>>> getData(
      int currentPage, int pageSize) async {
    pageSize = 18;
    int startIndex = (currentPage - 1) * pageSize;
    int endIndex = startIndex + pageSize - 1;
    var tabIndex = tabController.index;
    var assetType = tabs[tabIndex];
    List<CategoryItemModel> categoryItems = <CategoryItemModel>[];
    if (assetType.code == AssetTypeEnum.comic.code) {
      var comics = ComicService.instance.list();
      if (comics.length > pageSize) {
        if (endIndex < comics.length) {
          comics = comics.sublist(startIndex, endIndex);
        } else {
          comics = comics.sublist(startIndex, comics.length);
        }
      } else {
        if (currentPage > 1) {
          comics.clear();
        }
      }
      for (var comic in comics) {
        categoryItems.add(CategoryItemModel(
          categoryId: comic.comicId,
          assetType: assetType.code,
          title: comic.title,
          cover: comic.cover,
          objId: comic.comicId,
          chapterId: comic.browseChapterId,
        ));
      }
    } else if (assetType.code == AssetTypeEnum.novel.code) {
      var novels = NovelService.instance.list();
      if (novels.length > pageSize) {
        if (endIndex < novels.length) {
          novels = novels.sublist(startIndex, endIndex);
        } else {
          novels = novels.sublist(startIndex, novels.length);
        }
      } else {
        if (currentPage > 1) {
          novels.clear();
        }
      }
      for (var novel in novels) {
        categoryItems.add(CategoryItemModel(
          categoryId: novel.novelId,
          assetType: assetType.code,
          title: novel.title,
          cover: novel.cover,
          objId: novel.novelId,
          chapterId: novel.browseChapterId,
        ));
      }
    }
    var data = [<CategoryItemModel>[]];
    if (categoryItems.isNotEmpty) {
      for (int i = 0, len = categoryItems.length; i < len; i += 3) {
        var items = <CategoryItemModel>[];
        if (i < len) {
          items.add(categoryItems[i]);
        }
        if (i + 1 < len) {
          items.add(categoryItems[i + 1]);
        }
        if (i + 2 < len) {
          items.add(categoryItems[i + 2]);
        }
        data.add(items);
      }
    }
    return data;
  }
}
