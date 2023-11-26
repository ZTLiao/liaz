import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/upgrade/comic_upgrade_model.dart';

class ComicUpgradeController extends BasePageController<ComicUpgradeModel> {
  @override
  Future<List<ComicUpgradeModel>> getData(int currentPage, int pageSize) {
    var list = <ComicUpgradeModel>[
      ComicUpgradeModel(
          comicId: 1,
          title: '骨龙的宝贝',
          cover: 'https://images.dmzj.com/webpic/17/gulongdebaobei106.jpg',
          types: ['冒险', '魔法'],
          authors: ['雪白いち'],
          upgradeChapter: '第23话',
          updated: 1700755200000,
          comicChapterId: 1),
      ComicUpgradeModel(
          comicId: 1,
          title: '骨龙的宝贝',
          cover: 'https://images.dmzj.com/webpic/17/gulongdebaobei106.jpg',
          types: ['冒险', '魔法'],
          authors: ['雪白いち'],
          upgradeChapter: '第23话',
          updated: 1700755200000,
          comicChapterId: 1),
      ComicUpgradeModel(
          comicId: 1,
          title: '骨龙的宝贝',
          cover: 'https://images.dmzj.com/webpic/17/gulongdebaobei106.jpg',
          types: ['冒险', '魔法'],
          authors: ['雪白いち'],
          upgradeChapter: '第23话',
          updated: 1700755200000,
          comicChapterId: 1),
      ComicUpgradeModel(
          comicId: 1,
          title: '骨龙的宝贝',
          cover: 'https://images.dmzj.com/webpic/17/gulongdebaobei106.jpg',
          types: ['冒险', '魔法'],
          authors: ['雪白いち'],
          upgradeChapter: '第23话',
          updated: 1700755200000,
          comicChapterId: 1),
      ComicUpgradeModel(
          comicId: 1,
          title: '骨龙的宝贝',
          cover: 'https://images.dmzj.com/webpic/17/gulongdebaobei106.jpg',
          types: ['冒险', '魔法'],
          authors: ['雪白いち'],
          upgradeChapter: '第23话',
          updated: 1700755200000,
          comicChapterId: 1),
      ComicUpgradeModel(
          comicId: 1,
          title: '骨龙的宝贝',
          cover: 'https://images.dmzj.com/webpic/17/gulongdebaobei106.jpg',
          types: ['冒险', '魔法'],
          authors: ['雪白いち'],
          upgradeChapter: '第23话',
          updated: 1700755200000,
          comicChapterId: 1),
      ComicUpgradeModel(
          comicId: 1,
          title: '骨龙的宝贝',
          cover: 'https://images.dmzj.com/webpic/17/gulongdebaobei106.jpg',
          types: ['冒险', '魔法'],
          authors: ['雪白いち'],
          upgradeChapter: '第23话',
          updated: 1700755200000,
          comicChapterId: 1),
      ComicUpgradeModel(
          comicId: 1,
          title: '骨龙的宝贝',
          cover: 'https://images.dmzj.com/webpic/17/gulongdebaobei106.jpg',
          types: ['冒险', '魔法'],
          authors: ['雪白いち'],
          upgradeChapter: '第23话',
          updated: 1700755200000,
          comicChapterId: 1),
    ];
    return Future(() => list);
  }
}
