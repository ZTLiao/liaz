import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/category/category_item_model.dart';
import 'package:liaz/models/category/category_model.dart';
import 'package:liaz/requests/category_request.dart';

class CategoryHomeController extends BasePageController<List<CategoryItemModel>>
    with GetTickerProviderStateMixin {
  late TabController tabController;
  var categoryId = RxInt(0);

  var assetTypes = [
    AppString.all,
    AppString.comic,
    AppString.novel,
  ];

  Rx<List<CategoryModel>> categories = Rx<List<CategoryModel>>([]);

  var categoryRequest = CategoryRequest();

  CategoryHomeController() {
    categoryRequest.getCategory().then((value) => categories.value.addAll(value));
  }

  @override
  void onInit() {
    tabController = TabController(length: assetTypes.length, vsync: this);
    super.onInit();
  }

  @override
  Future<List<List<CategoryItemModel>>> getData(int currentPage, int pageSize) {
    var list = [
      [
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
      ],
      [
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
      ],
      [
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
      ],
      [
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
      ],
      [
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
      ],
      [
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryItemModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
      ],
    ];
    return Future(() => list);
  }
}
