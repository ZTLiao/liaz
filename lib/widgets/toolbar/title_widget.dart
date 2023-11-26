import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/models/dto/title_model.dart';
import 'package:remixicon/remixicon.dart';

class TitleWidget extends StatelessWidget {
  final TitleModel item;
  final Widget child;
  final Function()? onRefresh;
  final Function()? onMore;

  const TitleWidget(
      {required this.item,
      required this.child,
      this.onRefresh,
      this.onMore,
      super.key});

  @override
  Widget build(BuildContext context) {
    var showTitle = item.showTitle;
    if (showTitle == YesOrNo.no) {
      return child;
    }
    var title = item.title;
    var optType = item.optType;
    var childrens = <Widget>[
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16, height: 1.0, fontWeight: FontWeight.bold),
        ),
      )
    ];
    //无
    if (optType == OptTypeEnum.none.index) {
      childrens.add(const SizedBox(
        height: 48,
      ));
      //刷新
    } else if (optType == OptTypeEnum.refresh.index) {
      var sizedBox = SizedBox(
        height: 48,
        child: GestureDetector(
          onTap: onRefresh,
          child: const Row(
            children: [
              Icon(Remix.refresh_line, size: 18, color: Colors.grey),
            ],
          ),
        ),
      );
      childrens.add(sizedBox);
      //更多
    } else if (optType == OptTypeEnum.more.index) {
      var sizedBox = SizedBox(
        height: 48,
        child: GestureDetector(
          onTap: onMore,
          child: const Row(
            children: [
              Icon(Icons.read_more, size: 18, color: Colors.grey),
            ],
          ),
        ),
      );
      childrens.add(sizedBox);
    }
    return Padding(
      padding: AppStyle.edgeInsetsB8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppStyle.radius8,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: childrens,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
