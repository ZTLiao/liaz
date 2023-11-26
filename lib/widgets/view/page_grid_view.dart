import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/widgets/status/app_empty_widget.dart';
import 'package:liaz/widgets/status/app_error_widget.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';

class PageGridView extends StatelessWidget {
  final BasePageController pageController;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final EdgeInsets? padding;
  final bool isFirstRefresh;
  final bool isShowPageLoading;
  final double crossAxisSpacing, mainAxisSpacing;
  final int crossAxisCount;
  final bool isLoadMore;

  const PageGridView({
    required this.itemBuilder,
    required this.pageController,
    this.padding,
    this.isFirstRefresh = false,
    this.isShowPageLoading = false,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    required this.crossAxisCount,
    this.isLoadMore = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          EasyRefresh(
            header: const MaterialHeader(),
            footer: isLoadMore
                ? const MaterialFooter(
                    clamping: false, infiniteOffset: 70, triggerOffset: 70)
                : null,
            controller: pageController.easyRefreshController,
            refreshOnStart: isFirstRefresh,
            onLoad: isLoadMore ? pageController.onLoading : null,
            onRefresh: pageController.onRefresh,
            child: MasonryGridView.count(
              padding: padding ?? EdgeInsets.zero,
              controller: pageController.scrollController,
              itemCount: pageController.list.length,
              itemBuilder: itemBuilder,
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
            ),
          ),
          Offstage(
            offstage: !pageController.isPageEmpty.value,
            child: AppEmptyWidget(
              onRefresh: () => pageController.onRefresh(),
            ),
          ),
          Offstage(
            offstage:
                !(isShowPageLoading && pageController.isPageLoading.value),
            child: const AppLoadingWidget(),
          ),
          Offstage(
            offstage: !pageController.isPageError.value,
            child: AppErrorWidget(
              errorMsg: pageController.errorMsg.value,
              error: pageController.error,
              onRefresh: () => pageController.onRefresh(),
            ),
          ),
        ],
      ),
    );
  }
}
