import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/models/upgrade/novel_upgrade_model.dart';

class NovelUpgradeController extends BasePageController<NovelUpgradeModel> {
  @override
  Future<List<NovelUpgradeModel>> getData(int currentPage, int pageSize) {
    var list = <NovelUpgradeModel>[
      NovelUpgradeModel(
        novelId: 1,
        title: '堤亚穆帝国物语',
        cover:
        'https://www.23qb.com/files/article/image/214/214313/214313s.jpg',
        types: ['奇幻'],
        authors: ['餅月望'],
        upgradeChapter: '第十卷 插画',
        updated: 1700755200000,
        novelChapterId: 1,
      ),
      NovelUpgradeModel(
        novelId: 1,
        title: '堤亚穆帝国物语',
        cover:
        'https://www.23qb.com/files/article/image/214/214313/214313s.jpg',
        types: ['奇幻'],
        authors: ['餅月望'],
        upgradeChapter: '第十卷 插画',
        updated: 1700755200000,
        novelChapterId: 1,
      ),
      NovelUpgradeModel(
        novelId: 1,
        title: '堤亚穆帝国物语',
        cover:
        'https://www.23qb.com/files/article/image/214/214313/214313s.jpg',
        types: ['奇幻'],
        authors: ['餅月望'],
        upgradeChapter: '第十卷 插画',
        updated: 1700755200000,
        novelChapterId: 1,
      ),
      NovelUpgradeModel(
        novelId: 1,
        title: '堤亚穆帝国物语',
        cover:
        'https://www.23qb.com/files/article/image/214/214313/214313s.jpg',
        types: ['奇幻'],
        authors: ['餅月望'],
        upgradeChapter: '第十卷 插画',
        updated: 1700755200000,
        novelChapterId: 1,
      ),
      NovelUpgradeModel(
        novelId: 1,
        title: '堤亚穆帝国物语',
        cover:
        'https://www.23qb.com/files/article/image/214/214313/214313s.jpg',
        types: ['奇幻'],
        authors: ['餅月望'],
        upgradeChapter: '第十卷 插画',
        updated: 1700755200000,
        novelChapterId: 1,
      ),
      NovelUpgradeModel(
        novelId: 1,
        title: '堤亚穆帝国物语',
        cover:
        'https://www.23qb.com/files/article/image/214/214313/214313s.jpg',
        types: ['奇幻'],
        authors: ['餅月望'],
        upgradeChapter: '第十卷 插画',
        updated: 1700755200000,
        novelChapterId: 1,
      ),
      NovelUpgradeModel(
        novelId: 1,
        title: '堤亚穆帝国物语',
        cover:
        'https://www.23qb.com/files/article/image/214/214313/214313s.jpg',
        types: ['奇幻'],
        authors: ['餅月望'],
        upgradeChapter: '第十卷 插画',
        updated: 1700755200000,
        novelChapterId: 1,
      ),
    ];
    return Future(() => list);
  }
}
