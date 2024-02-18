import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/models/category/category_item_model.dart';
import 'package:liaz/models/category/category_model.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/requests/category_request.dart';
import 'package:liaz/requests/category_search_request.dart';
import 'package:liaz/requests/comic_request.dart';
import 'package:liaz/requests/novel_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/novel_service.dart';

class CategoryHomeController extends BasePageController<List<CategoryItemModel>>
    with GetTickerProviderStateMixin {
  late TabController tabController;

  /// 资源
  var assetType = RxInt(AssetTypeEnum.all.code);

  /// 分类ID
  var categoryId = RxInt(0);

  Rx<List<CategoryModel>> categories = Rx<List<CategoryModel>>([]);

  var categoryRequest = CategoryRequest();

  var categorySearchRequest = CategorySearchRequest();

  var comicRequest = ComicRequest();

  var novelRequest = NovelRequest();

  CategoryHomeController() {
    tabController =
        TabController(length: AssetTypeEnum.values.length, vsync: this);
    if (categories.value.isEmpty) {
      categoryRequest.getCategory().then((value) {
        categories.value.addAll(value);
        categoryId.value = categories.value[0].categoryId;
        onRefresh();
      });
    }
  }

  void setIndex(i) {
    assetType.value = i;
    onRefresh();
  }

  @override
  Future<List<List<CategoryItemModel>>> getData(
      int currentPage, int pageSize) async {
    if (categoryId.value == 0) {
      return [];
    }
    var categories = await categorySearchRequest.getContent(
        AssetTypeEnum.values[tabController.index].index,
        categoryId.value,
        currentPage,
        18);
    var data = [<CategoryItemModel>[]];
    if (categories.isNotEmpty) {
      for (int i = 0, len = categories.length; i < len; i += 3) {
        var items = <CategoryItemModel>[];
        if (i < len) {
          items.add(categories[i]);
        }
        if (i + 1 < len) {
          items.add(categories[i + 1]);
        }
        if (i + 2 < len) {
          items.add(categories[i + 2]);
        }
        data.add(items);
      }
    }
    return data;
  }

  void onReadChapter(ItemModel item) async {
    var skipType = item.skipType;
    if (item.skipValue == null) {
      return;
    }
    var skipValue = item.skipValue;
    if (skipValue == null || int.parse(skipValue) == 0) {
      var objId = item.objId!;
      if (SkipTypeEnum.comic.index == skipType) {
        ComicService.instance.toComicDetail(objId);
      } else if (SkipTypeEnum.novel.index == skipType) {
        NovelService.instance.toNovelDetail(objId);
      }
    } else {
      var objId = int.parse(skipValue);
      if (SkipTypeEnum.comic.index == skipType) {
        var chapters = await comicRequest.getComicCatalogue(objId);
        AppNavigator.toComicReader(
          comicChapterId: objId,
          chapters: chapters,
        );
      } else if (SkipTypeEnum.novel.index == skipType) {
        var chapters = await novelRequest.getNovelCatalogue(objId);
        AppNavigator.toNovelReader(
          novelChapterId: objId,
          chapters: chapters,
        );
      }
    }
  }
}
