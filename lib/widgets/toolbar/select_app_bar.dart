import 'package:flutter/material.dart';
import 'package:liaz/app/utils/str_util.dart';

class SelectAppBar extends StatelessWidget {
  final Map<int, String> types;
  final int value;
  final Function(int) onSelected;

  const SelectAppBar(
      {required this.types,
      required this.value,
      required this.onSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: onSelected,
      itemBuilder: (c) => types.keys
          .map(
            (k) => CheckedPopupMenuItem<int>(
              value: k,
              checked: k == value,
              child: Text(types[k] ?? StrUtil.empty),
            ),
          )
          .toList(),
      child: SizedBox(
        height: 36,
        child: Row(
          children: <Widget>[
            Text(
              types[value] ?? StrUtil.empty,
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
