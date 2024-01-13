import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/models/category/category_item_model.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_check_listener.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_subscribe_listener.dart';
import 'package:liaz/requests/bookshelf_request.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/novel_service.dart';

class BookshelfHomeController
    extends BasePageController<List<CategoryItemModel>>
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var bookshelfs = [
    AssetTypeEnum.comic,
    AssetTypeEnum.novel,
  ];

  var sortType = RxInt(0);

  var bookshelfRequest = BookshelfRequest();

  @override
  void onInit() {
    EventBus.instance
        .subscribe(AppEvent.kNavigationTopic, BookshelfCheckListener());
    EventBus.instance
        .subscribe(AppEvent.kSubscribeComicTopic, BookshelfSubscribeListener());
    EventBus.instance
        .subscribe(AppEvent.kSubscribeNovelTopic, BookshelfSubscribeListener());
    tabController = TabController(length: bookshelfs.length, vsync: this);
    super.onInit();
  }

  @override
  Future<List<List<CategoryItemModel>>> getData(
      int currentPage, int pageSize) async {
    pageSize = 18;
    var tabIndex = tabController.index;
    var assetType = bookshelfs[tabIndex];
    List<CategoryItemModel> categoryItems = <CategoryItemModel>[];
    if (assetType.code == AssetTypeEnum.comic.code) {
      categoryItems = await bookshelfRequest.getComic(
          sortType.value, currentPage, pageSize);
    } else if (assetType.code == AssetTypeEnum.novel.code) {
      categoryItems = await bookshelfRequest.getNovel(
          sortType.value, currentPage, pageSize);
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

  void onReadChapter(ItemModel item) {
    var itemId = item.itemId;
    var skipType = item.skipType;
    var objId = item.objId;
    var skipValue = objId;
    if (objId == null || objId == 0) {
      skipValue = itemId;
      if (skipType == SkipTypeEnum.comic.index) {
        ComicService.instance.toComicDetail(skipValue);
      } else if (skipType == SkipTypeEnum.novel.index) {
        NovelService.instance.toNovelDetail(skipValue);
      }
    } else {
      if (skipType == SkipTypeEnum.comic.index) {
        ComicService.instance.toReadChapter(skipValue!);
      } else if (skipType == SkipTypeEnum.novel.index) {
        NovelService.instance.toReadChapter(skipValue!);
      }
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
