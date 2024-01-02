import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankItemWidget extends StatelessWidget {
  final int index;
  final Widget child;

  const RankItemWidget({required this.index, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    if (index == 1) {
      icon = Icons.emoji_events;
      color = const Color.fromRGBO(218, 178, 115, 1);
    } else if (index == 2) {
      icon = Icons.emoji_events;
      color = const Color.fromRGBO(233, 233, 216, 1);
    } else if (index == 3) {
      icon = Icons.emoji_events;
      color = const Color.fromRGBO(186, 110, 64, 1);
    } else {
      icon = Icons.circle;
      color = Get.isDarkMode ? Colors.white24 : Colors.black26;
    }
    return Row(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Icon(
                icon,
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
