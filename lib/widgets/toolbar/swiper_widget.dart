import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';

class SwiperWidget extends StatelessWidget {
  final double _width = 750;
  final double _height = 300;

  final List<ItemModel> items;

  const SwiperWidget({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.edgeInsetsB12,
      child: ClipRRect(
        borderRadius: AppStyle.radius4,
        child: AspectRatio(
          aspectRatio: _width / _height,
          child: Swiper(
            itemWidth: _width,
            itemHeight: _height,
            duration: 1000,
            autoplay: true,
            itemCount: items.length,
            itemBuilder: (_, i) => Stack(
              children: [
                NetImage(
                  items[i].showValue,
                  width: _width,
                  height: _height,
                ),
                Positioned(
                    bottom: 4,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        items[i].title,
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                blurRadius: 6.0,
                                color: Colors.black45,
                                offset: Offset(2.0, 2.0))
                          ],
                        ),
                      ),
                    ))
              ],
            ),
            onTap: (i) {
              onOpen(items[i]);
            },
            pagination: const SwiperPagination(
                margin: AppStyle.edgeInsetsA8,
                alignment: Alignment.bottomRight,
                builder: DotSwiperPaginationBuilder(activeColor: Colors.cyan)),
          ),
        ),
      ),
    );
  }

  void onOpen(ItemModel item) {
    SmartDialog.showToast(AppString.skipError);
  }
}
