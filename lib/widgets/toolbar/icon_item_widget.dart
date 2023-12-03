import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_style.dart';

class IconItemWidget extends StatelessWidget {
  final List<Widget> children;
  final IconData? iconData;

  const IconItemWidget(
      {required this.children, this.iconData, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconData != null ? Icon(
            iconData,
            color: Colors.grey,
            size: 16,
          ) : const SizedBox(),
          AppStyle.hGap8,
          Expanded(
            child: Wrap(
              spacing: 8,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
