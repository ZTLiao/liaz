import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/models/dto/title_model.dart';
import 'package:remixicon/remixicon.dart';

class TitleWidget extends StatelessWidget {
  final TitleModel item;
  final Widget child;
  final Color? color;
  final IconData? icon;
  final Function()? onTap;

  const TitleWidget(
      {required this.item,
      required this.child,
      this.color,
      this.icon,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    var showTitle = item.showTitle;
    if (showTitle == YesOrNo.no) {
      return child;
    }
    var title = item.title;
    var childrens = <Widget>[
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            height: 1.0,
            fontWeight: FontWeight.bold,
            color: color ?? (Get.isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      )
    ];
    var sizedBox = SizedBox(
      height: 48,
      child: icon != null
          ? GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: Colors.grey,
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
    childrens.add(sizedBox);
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
