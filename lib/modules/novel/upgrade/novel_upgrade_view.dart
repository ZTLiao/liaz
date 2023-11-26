import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/card_item_model.dart';
import 'package:liaz/modules/novel/upgrade/novel_upgrade_controller.dart';
import 'package:liaz/widgets/keep_alive_wrapper.dart';
import 'package:liaz/widgets/toolbar/card_item_widget.dart';
import 'package:liaz/widgets/view/page_list_view.dart';

class NovelUpgradeView extends StatelessWidget {
  final NovelUpgradeController controller;

  NovelUpgradeView({super.key})
      : controller = Get.put(NovelUpgradeController());

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
          pageController: controller,
          isFirstRefresh: true,
          isLoadMore: true,
          isShowPageLoading: false,
          separatorBuilder: (context, i) => Divider(
                endIndent: 12,
                indent: 12,
                color: Colors.grey.withOpacity(.2),
                height: 1,
              ),
          itemBuilder: (context, i) {
            var item = controller.list[i];
            var types = StrUtil.listToStr(item.types, StrUtil.slash);
            var authors = StrUtil.listToStr(item.authors, StrUtil.slash);
            var updateTime = DateUtil.formatDate(item.updated);
            var card = CardItemModel(
                cardId: item.novelId,
                title: item.title,
                cover: item.cover,
                cardType: AssetTypeEnum.novel.index,
                types: types,
                authors: authors,
                upgradeChapter: item.upgradeChapter,
                updateTime: updateTime,
                objId: item.novelChapterId);
            return CardItemWidget(card: card);
          }),
    );
  }
}
