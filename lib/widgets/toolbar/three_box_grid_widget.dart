import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';

class ThreeBoxGridWidget extends StatelessWidget {
  final double _width = 270;
  final double _height = 360;

  final List<ItemModel> items;
  final Function(ItemModel item)? onTap;

  const ThreeBoxGridWidget({required this.items, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: items.length,
      itemBuilder: (_, i) {
        var item = items[i];
        var subTitle = item.subTitle ?? StrUtil.empty;
        bool isUpgrade =
            item.isUpgrade != null && item.isUpgrade == YesOrNo.yes;
        if (isUpgrade) {
          subTitle = AppString.updateTo + StrUtil.space + subTitle;
        }
        return InkWell(
          onTap: () => onTap!(item),
          borderRadius: AppStyle.radius4,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: AppStyle.radius4,
                    child: AspectRatio(
                      aspectRatio: _width / _height,
                      child: NetImage(
                        item.showValue,
                        width: _width,
                        height: _height,
                      ),
                    ),
                  ),
                  AppStyle.vGap8,
                  Text(
                    item.title,
                    maxLines: 1,
                    style: const TextStyle(height: 1.2),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subTitle,
                    maxLines: 1,
                    style: const TextStyle(
                      height: 1.2,
                      fontSize: 12,
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AppStyle.vGap8,
                ],
              ),
              isUpgrade
                  ? const Positioned(
                      top: -5,
                      right: -8,
                      child: Stack(
                        children: [
                          Icon(
                            Icons.bookmark,
                            color: Colors.red,
                            size: 35,
                          ),
                          Positioned(
                            top: 10,
                            right: 9,
                            child: Text(
                              AppString.latest,
                              style: TextStyle(
                                fontSize: 7,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
