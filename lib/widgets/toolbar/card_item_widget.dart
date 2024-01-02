import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/card_item_model.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';

class CardItemWidget extends StatelessWidget {
  final CardItemModel card;
  final Function(int)? onTap;
  final Function(int)? onOpen;

  const CardItemWidget(
      {required this.card, this.onTap, this.onOpen, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(card.cardId),
      child: Container(
        padding: AppStyle.edgeInsetsA12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NetImage(
              card.cover,
              width: 80,
              height: 110,
              borderRadius: 4,
            ),
            AppStyle.hGap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    card.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppStyle.vGap2,
                  Text.rich(
                    TextSpan(children: [
                      const WidgetSpan(
                          child: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.grey,
                        size: 18,
                      )),
                      const TextSpan(
                        text: StrUtil.space,
                      ),
                      TextSpan(
                          text: card.authors,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                  ),
                  AppStyle.vGap2,
                  Text.rich(
                    TextSpan(children: [
                      const WidgetSpan(
                          child: Icon(
                        Icons.label_outline,
                        color: Colors.grey,
                        size: 18,
                      )),
                      const TextSpan(
                        text: StrUtil.space,
                      ),
                      TextSpan(
                          text: card.categories,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                  ),
                  AppStyle.vGap2,
                  Text.rich(
                    TextSpan(children: [
                      const WidgetSpan(
                          child: Icon(
                        Icons.star_outline,
                        color: Colors.grey,
                        size: 18,
                      )),
                      const TextSpan(
                        text: StrUtil.space,
                      ),
                      TextSpan(
                          text: card.upgradeChapter,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                  ),
                  AppStyle.vGap2,
                  Text.rich(
                    TextSpan(children: [
                      const WidgetSpan(
                          child: Icon(
                        Icons.schedule,
                        color: Colors.grey,
                        size: 18,
                      )),
                      const TextSpan(
                        text: StrUtil.space,
                      ),
                      TextSpan(
                          text: card.updateTime,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  AppStyle.vGap12,
                  IconButton(
                    icon: const Icon(Icons.menu_book_outlined),
                    onPressed: () {
                      if (onOpen != null) {
                        onOpen!(card.objId);
                      }
                    },
                  ),
                  SizedBox(
                    width: 45,
                    child: Center(
                      child: Text(
                        card.upgradeChapter,
                        maxLines: 1,
                        style: const TextStyle(
                          height: 1.2,
                          fontSize: 14,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
