import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';

class UserPhoto extends StatelessWidget {
  final String? url;
  final bool showBorder;
  final double size;

  const UserPhoto({
    this.url,
    this.showBorder = true,
    this.size = 48,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null || (url?.isEmpty ?? true)) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: showBorder
              ? Border.all(
                  color: Colors.grey.withOpacity(.2),
                )
              : null,
          color: Colors.grey.withOpacity(.2),
          borderRadius: AppStyle.radius32,
        ),
        child: const Icon(
          Icons.person,
          color: Colors.white,
          size: 24,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(56),
        border: showBorder
            ? Border.all(
                color: Colors.grey.withOpacity(.2),
              )
            : null,
      ),
      child: NetImage(
        url!,
        width: size,
        height: size,
        borderRadius: size,
      ),
    );
  }
}
