import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/widgets/status/app_empty_widget.dart';
import 'package:liaz/widgets/status/app_error_widget.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';

class PageListView extends StatelessWidget {
  final BasePageController pageController;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final EdgeInsets? padding;
  final bool isFirstRefresh;
  final bool isShowPageLoading;
  final bool isLoadMore;
  final Widget? header;

  const PageListView({
    required this.pageController,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.isFirstRefresh = false,
    this.isShowPageLoading = false,
    this.isLoadMore = false,
    this.header,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            EasyRefresh(
              header: const MaterialHeader(),
              footer: isLoadMore
                  ? const MaterialFooter(
                      clamping: false, infiniteOffset: 70, triggerOffset: 70)
                  : null,
              controller: pageController.easyRefreshController,
              onLoad: isLoadMore ? pageController.onLoading : null,
              onRefresh: pageController.onRefresh,
              child: ListView.separated(
                padding: padding ?? EdgeInsets.zero,
                controller: pageController.scrollController,
                itemCount: header == null
                    ? pageController.list.length
                    : pageController.list.length + 1,
                itemBuilder: header == null
                    ? itemBuilder
                    : (context, index) {
                        if (index == 0) {
                          return header;
                        }
                        return itemBuilder.call(context, index - 1);
                      },
                separatorBuilder: header == null
                    ? (separatorBuilder ?? (context, index) => const SizedBox())
                    : (context, index) {
                        if (index == 0) {
                          return const SizedBox();
                        }
                        return separatorBuilder?.call(context, index - 1) ??
                            const SizedBox();
                      },
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
            )
          ],
        ));
  }
}
