import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/card_model.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';
import 'package:remixicon/remixicon.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;

  const CardWidget({required this.card, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
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
                        Remix.user_line,
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
                        Remix.price_tag_3_line,
                        color: Colors.grey,
                        size: 18,
                      )),
                      const TextSpan(
                        text: StrUtil.space,
                      ),
                      TextSpan(
                          text: card.types,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                  ),
                  AppStyle.vGap2,
                  Text.rich(
                    TextSpan(children: [
                      const WidgetSpan(
                          child: Icon(
                            Remix.star_line,
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
                        Remix.time_line,
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
                      icon: const Icon(Remix.book_open_line),
                      onPressed: () {
                        SmartDialog.showToast(AppString.skipError);
                      }),
                  SizedBox(
                    width: 45,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTop() {
    SmartDialog.showToast(AppString.skipError);
  }
}
