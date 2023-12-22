import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_style.dart';

class TabAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final Widget? action;
  final bool isScrollable;
  final TabAlignment? tabAlignment;
  final double selectedSize;
  final double unselectedSize;
  final ValueChanged<int>? onTap;

  const TabAppBar(
      {required this.tabs,
      this.controller,
      this.action,
      this.tabAlignment,
      this.isScrollable = true,
      this.selectedSize = 12,
      this.unselectedSize = 12,
      this.onTap,
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
        alignment: Alignment.centerLeft,
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: 4),
        height: 56 + MediaQuery.of(context).padding.top,
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                tabAlignment: tabAlignment,
                isScrollable: isScrollable,
                controller: controller,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor:
                    Get.isDarkMode ? Colors.white70 : Colors.black87,
                labelStyle: TextStyle(
                  fontSize: selectedSize,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: unselectedSize,
                  fontWeight: FontWeight.bold,
                ),
                labelPadding: AppStyle.edgeInsetsH12,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.transparent,
                tabs: tabs,
                onTap: onTap,
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
