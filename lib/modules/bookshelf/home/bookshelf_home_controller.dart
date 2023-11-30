import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/category/category_model.dart';

class BookshelfHomeController extends BasePageController<List<CategoryModel>>
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  Future<List<List<CategoryModel>>> getData(int currentPage, int pageSize) {
    var list = [
      [
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
              'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
      ],
      [
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
      ],
      [
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
      ],
      [
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
      ],
      [
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
        CategoryModel(
          categoryId: 1,
          assetType: 1,
          title: '海滨的鲨鱼女仆',
          cover:
          'https://images.dmzj.com/webpic/17/haibindeshayunvpu231110.jpg',
          authors: ['テルヤ'],
          objId: 1,
        ),
      ],
    ];
    return Future(() => list);
  }
}
