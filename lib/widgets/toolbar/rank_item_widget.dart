import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:remixicon/remixicon.dart';

class RankItemWidget extends StatelessWidget {
  final int index;
  final Widget child;

  const RankItemWidget({required this.index, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    Color color;
    if (index == 1) {
      color = const Color.fromRGBO(218, 178, 115, 1);
    } else if (index == 2) {
      color = const Color.fromRGBO(233, 233, 216, 1);
    } else if (index == 3) {
      color = const Color.fromRGBO(186, 110, 64, 1);
    } else {
      color = AppColor.black33;
    }
    return Row(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Icon(
                Remix.vip_crown_fill,
                color: color,
                size: 30,
              ),
              Text(
                index.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
