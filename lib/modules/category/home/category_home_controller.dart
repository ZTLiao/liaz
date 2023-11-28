import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/category/category_model.dart';

class CategoryHomeController extends BasePageController<List<CategoryModel>>
    with GetTickerProviderStateMixin {
  late TabController tabController;
  var categoryId = RxInt(0);

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

  @override
  Future<List<List<CategoryModel>>> getData(int currentPage, int pageSize) {
    var list = [
      [
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
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
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
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
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
              'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
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
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
          'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
          'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
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
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
          'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
          'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
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
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
          'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '史上最垃圾伪圣女',
          cover:
          'https://images.dmzj.com/webpic/5/shishangzuilajiweishennv_29_03_2023.jpg',
          authors: ['えかきびと', '壁首领大公'],
          objId: 1,
        ),
        CategoryModel(
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
