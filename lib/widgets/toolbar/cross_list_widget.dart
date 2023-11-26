import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';

class CrossListWidget extends StatelessWidget {
  final double _width = 270;
  final double _height = 360;
  final List<ItemModel> items;
  final Function()? onRefresh;
  final Function()? onMore;

  const CrossListWidget(
      {required this.items, this.onRefresh, this.onMore, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const IgnorePointer(
          child: Opacity(
            opacity: 0.0,
            child: SizedBox(
              height: 165,
            ),
          ),
        ),
        const SizedBox(
          width: double.infinity,
        ),
        Positioned.fill(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (_, index) {
                var item = items[index];
                return InkWell(
                  onTap: () => onOpen(item),
                  borderRadius: AppStyle.radius4,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
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
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              item.title,
                              maxLines: 1,
                              style: const TextStyle(
                                height: 1.2,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              item.subTitle ?? StrUtil.empty,
                              maxLines: 1,
                              style: const TextStyle(
                                height: 1.2,
                                fontSize: 12,
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppStyle.hGap8,
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  void onOpen(ItemModel item) {
    SmartDialog.showToast(AppString.skipError);
  }
}
