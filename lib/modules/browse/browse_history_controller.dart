import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/card_item_model.dart';
import 'package:liaz/requests/browse_request.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/novel_service.dart';

class BrowseHistoryController extends BasePageController<CardItemModel> {
  final _browseRequest = BrowseRequest();

  @override
  Future<List<CardItemModel>> getData(int currentPage, int pageSize) async {
    var browses = await _browseRequest.browseRecord(currentPage, pageSize);
    List<CardItemModel> data = [];
    if (browses.isEmpty) {
      return data;
    }
    for (var item in browses) {
      data.add(CardItemModel(
        cardId: item.objId,
        title: item.title,
        cover: item.cover,
        cardType: item.assetType,
        categories: StrUtil.empty,
        authors: StrUtil.empty,
        upgradeChapter: item.chapterName,
        updateTime: DateUtil.formatDateTimeMinute(item.updatedAt),
        objId: item.chapterId,
      ));
    }
    return data;
  }

  onDetail(CardItemModel card) {
    var cardType = card.cardType;
    if (AssetTypeEnum.comic.index == cardType) {
      ComicService.instance.toComicDetail(card.cardId);
    } else if (AssetTypeEnum.novel.index == cardType) {
      NovelService.instance.toNovelDetail(card.cardId);
    }
  }

  onReadChapter(CardItemModel card) {
    var chapterId = card.objId!;
    var cardType = card.cardType;
    if (AssetTypeEnum.comic.index == cardType) {
      ComicService.instance.toReadChapter(chapterId);
    } else if (AssetTypeEnum.novel.index == cardType) {
      NovelService.instance.toReadChapter(chapterId);
    }
  }
}
