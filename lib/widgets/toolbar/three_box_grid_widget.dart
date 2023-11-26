import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';

class ThreeBoxGridWidget extends StatelessWidget {
  final double _width = 270;
  final double _height = 360;

  final List<ItemModel> items;

  const ThreeBoxGridWidget({required this.items, super.key});

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
        return InkWell(
          onTap: () => onOpen(item),
          borderRadius: AppStyle.radius4,
          child: Column(
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
                item.subTitle ?? StrUtil.empty,
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
        );
      },
    );
  }

  void onOpen(ItemModel item) {
    SmartDialog.showToast(AppString.skipError);
  }
}
