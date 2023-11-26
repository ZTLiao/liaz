import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';

class BasePageController<T> extends BaseController {
  final ScrollController scrollController = ScrollController();
  final EasyRefreshController easyRefreshController = EasyRefreshController();

  /// 当前页
  int currentPage = 1;

  /// 每页显示数
  int pageSize = 24;
  var isCanLoadMore = RxBool(false);

  /// 数据
  var list = RxList<T>([]);

  Future<void> onRefresh() async {
    this.currentPage = 1;
    this.list.clear();
    //重新加载
    await onLoading();
  }

  Future<void> onLoading() async {
    if (isLoading) {
      return;
    }
    try {
      error = null;
      isLoading = true;
      isPageError.value = false;
      isPageEmpty.value = false;
      //页面开始更新
      isPageLoading.value = true;
      //获取数据
      var result = await getData(this.currentPage, this.pageSize);
      var isNotEmpty = result.isNotEmpty;
      isCanLoadMore.value = isNotEmpty;
      if (isNotEmpty) {
        this.currentPage++;
        this.list.addAll(result);
      }
      if (this.currentPage == 1) {
        isPageEmpty.value = true;
      }
    } catch (e) {
      except(e);
    } finally {
      isLoading = false;
      isPageLoading.value = false;
    }
  }

  Future<List<T>> getData(int currentPage, int pageSize) async {
    return [];
  }
}
