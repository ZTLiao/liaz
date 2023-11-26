import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_style.dart';

class TabAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final Widget? action;
  final bool isScrollable;

  const TabAppBar(
      {required this.tabs,
      this.controller,
      this.action,
      this.isScrollable = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Get.isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarColor: Colors.transparent,
            ),
      child: Container(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: 4),
        height: 56 + MediaQuery.of(context).padding.top,
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                isScrollable: isScrollable,
                controller: controller,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor:
                    Get.isDarkMode ? Colors.white70 : Colors.black87,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                labelPadding: AppStyle.edgeInsetsH12,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.transparent,
                tabs: tabs,
              ),
            ),
            action ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56 + AppStyle.statusBarHeight);
}
