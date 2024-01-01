import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/comic/comic_item_model.dart';
import 'package:liaz/models/dto/card_item_model.dart';
import 'package:liaz/models/novel/novel_item_model.dart';

class IndexRankController extends BasePageController<CardItemModel>
    with GetTickerProviderStateMixin {
  late TabController tabController;
  var assetType = RxInt(AssetTypeEnum.comic.code);
  var timeType = RxInt(0);

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  Future<List<CardItemModel>> getData(int currentPage, int pageSize) {
    var tabIndex = tabController.index;
    Log.i(
        'rankType : $tabIndex, assetType : ${assetType.value}, timeType : ${timeType.value}');
    List<CardItemModel> list = [];
    if (assetType.value == AssetTypeEnum.comic.index) {
      var data = <ComicItemModel>[
        ComicItemModel(
          comicId: 1,
          title: '消极勇者与魔王军干部',
          cover:
              'https://images.dmzj.com/webpic/6/xiaojiyongzheyumowangjunganbu_06_10_2023.jpg',
          categories: ['冒险', '欢乐向', '魔法'],
          authors: ['ハマちょん'],
          upgradeChapter: '第29话',
          updated: 1700998213000,
          comicChapterId: 1,
        ),
        ComicItemModel(
          comicId: 1,
          title: '消极勇者与魔王军干部',
          cover:
              'https://images.dmzj.com/webpic/6/xiaojiyongzheyumowangjunganbu_06_10_2023.jpg',
          categories: ['冒险', '欢乐向', '魔法'],
          authors: ['ハマちょん'],
          upgradeChapter: '第29话',
          updated: 1700998213000,
          comicChapterId: 1,
        ),
        ComicItemModel(
          comicId: 1,
          title: '消极勇者与魔王军干部',
          cover:
              'https://images.dmzj.com/webpic/6/xiaojiyongzheyumowangjunganbu_06_10_2023.jpg',
          categories: ['冒险', '欢乐向', '魔法'],
          authors: ['ハマちょん'],
          upgradeChapter: '第29话',
          updated: 1700998213000,
          comicChapterId: 1,
        ),
        ComicItemModel(
          comicId: 1,
          title: '消极勇者与魔王军干部',
          cover:
              'https://images.dmzj.com/webpic/6/xiaojiyongzheyumowangjunganbu_06_10_2023.jpg',
          categories: ['冒险', '欢乐向', '魔法'],
          authors: ['ハマちょん'],
          upgradeChapter: '第29话',
          updated: 1700998213000,
          comicChapterId: 1,
        ),
        ComicItemModel(
          comicId: 1,
          title: '消极勇者与魔王军干部',
          cover:
              'https://images.dmzj.com/webpic/6/xiaojiyongzheyumowangjunganbu_06_10_2023.jpg',
          categories: ['冒险', '欢乐向', '魔法'],
          authors: ['ハマちょん'],
          upgradeChapter: '第29话',
          updated: 1700998213000,
          comicChapterId: 1,
        ),
        ComicItemModel(
          comicId: 1,
          title: '消极勇者与魔王军干部',
          cover:
              'https://images.dmzj.com/webpic/6/xiaojiyongzheyumowangjunganbu_06_10_2023.jpg',
          categories: ['冒险', '欢乐向', '魔法'],
          authors: ['ハマちょん'],
          upgradeChapter: '第29话',
          updated: 1700998213000,
          comicChapterId: 1,
        ),
        ComicItemModel(
          comicId: 1,
          title: '消极勇者与魔王军干部',
          cover:
              'https://images.dmzj.com/webpic/6/xiaojiyongzheyumowangjunganbu_06_10_2023.jpg',
          categories: ['冒险', '欢乐向', '魔法'],
          authors: ['ハマちょん'],
          upgradeChapter: '第29话',
          updated: 1700998213000,
          comicChapterId: 1,
        ),
        ComicItemModel(
          comicId: 1,
          title: '消极勇者与魔王军干部',
          cover:
              'https://images.dmzj.com/webpic/6/xiaojiyongzheyumowangjunganbu_06_10_2023.jpg',
          categories: ['冒险', '欢乐向', '魔法'],
          authors: ['ハマちょん'],
          upgradeChapter: '第29话',
          updated: 1700998213000,
          comicChapterId: 1,
        ),
      ];
      for (var i = 0, len = data.length; i < len; i++) {
        var item = data[i];
        var categories = StrUtil.listToStr(item.categories, StrUtil.slash);
        var authors = StrUtil.listToStr(item.authors, StrUtil.slash);
        var updateTime = DateUtil.formatDate(item.updated);
        var card = CardItemModel(
            cardId: item.comicId,
            title: item.title,
            cover: item.cover,
            cardType: AssetTypeEnum.comic.index,
            categories: categories,
            authors: authors,
            upgradeChapter: item.upgradeChapter,
            updateTime: updateTime,
            objId: item.comicChapterId);
        list.add(card);
      }
    } else if (assetType.value == AssetTypeEnum.novel.index) {
      var data = <NovelItemModel>[
        NovelItemModel(
          novelId: 1,
          title: '关于我转生变成史莱姆这档事',
          cover:
              'https://otu1.dodomh.com/images/o/c1/61/e154030c63519dbf4e3220ace76c.jpg',
          categories: ['魔法', '冒险'],
          authors: ['伏濑'],
          upgradeChapter: '外传 井泽静江之章',
          updated: 1698319813000,
          novelChapterId: 1,
        ),
        NovelItemModel(
          novelId: 1,
          title: '关于我转生变成史莱姆这档事',
          cover:
              'https://otu1.dodomh.com/images/o/c1/61/e154030c63519dbf4e3220ace76c.jpg',
          categories: ['魔法', '冒险'],
          authors: ['伏濑'],
          upgradeChapter: '外传 井泽静江之章',
          updated: 1698319813000,
          novelChapterId: 1,
        ),
        NovelItemModel(
          novelId: 1,
          title: '关于我转生变成史莱姆这档事',
          cover:
              'https://otu1.dodomh.com/images/o/c1/61/e154030c63519dbf4e3220ace76c.jpg',
          categories: ['魔法', '冒险'],
          authors: ['伏濑'],
          upgradeChapter: '外传 井泽静江之章',
          updated: 1698319813000,
          novelChapterId: 1,
        ),
        NovelItemModel(
          novelId: 1,
          title: '关于我转生变成史莱姆这档事',
          cover:
              'https://otu1.dodomh.com/images/o/c1/61/e154030c63519dbf4e3220ace76c.jpg',
          categories: ['魔法', '冒险'],
          authors: ['伏濑'],
          upgradeChapter: '外传 井泽静江之章',
          updated: 1698319813000,
          novelChapterId: 1,
        ),
        NovelItemModel(
          novelId: 1,
          title: '关于我转生变成史莱姆这档事',
          cover:
              'https://otu1.dodomh.com/images/o/c1/61/e154030c63519dbf4e3220ace76c.jpg',
          categories: ['魔法', '冒险'],
          authors: ['伏濑'],
          upgradeChapter: '外传 井泽静江之章',
          updated: 1698319813000,
          novelChapterId: 1,
        ),
        NovelItemModel(
          novelId: 1,
          title: '关于我转生变成史莱姆这档事',
          cover:
              'https://otu1.dodomh.com/images/o/c1/61/e154030c63519dbf4e3220ace76c.jpg',
          categories: ['魔法', '冒险'],
          authors: ['伏濑'],
          upgradeChapter: '外传 井泽静江之章',
          updated: 1698319813000,
          novelChapterId: 1,
        ),
        NovelItemModel(
          novelId: 1,
          title: '关于我转生变成史莱姆这档事',
          cover:
              'https://otu1.dodomh.com/images/o/c1/61/e154030c63519dbf4e3220ace76c.jpg',
          categories: ['魔法', '冒险'],
          authors: ['伏濑'],
          upgradeChapter: '外传 井泽静江之章',
          updated: 1698319813000,
          novelChapterId: 1,
        ),
        NovelItemModel(
          novelId: 1,
          title: '关于我转生变成史莱姆这档事',
          cover:
              'https://otu1.dodomh.com/images/o/c1/61/e154030c63519dbf4e3220ace76c.jpg',
          categories: ['魔法', '冒险'],
          authors: ['伏濑'],
          upgradeChapter: '外传 井泽静江之章',
          updated: 1698319813000,
          novelChapterId: 1,
        ),
      ];
      for (var i = 0, len = data.length; i < len; i++) {
        var item = data[i];
        var types = StrUtil.listToStr(item.categories, StrUtil.slash);
        var authors = StrUtil.listToStr(item.authors, StrUtil.slash);
        var updateTime = DateUtil.formatDate(item.updated);
        var card = CardItemModel(
            cardId: item.novelId,
            title: item.title,
            cover: item.cover,
            cardType: AssetTypeEnum.comic.index,
            categories: types,
            authors: authors,
            upgradeChapter: item.upgradeChapter,
            updateTime: updateTime,
            objId: item.novelChapterId);
        list.add(card);
      }
    }
    return Future(() => list);
  }
}
