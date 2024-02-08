import 'package:flutter/material.dart';
import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/app/enums/recommend_position_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/requests/recommend_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/advert_service.dart';
import 'package:liaz/services/recommend_service.dart';

class IndexRecommendController extends BasePageController<RecommendModel>
    with WidgetsBindingObserver {
  var recommendRequest = RecommendRequest();

  var isAdvertLoading = false;

  var isFirst = true;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<List<RecommendModel>> getData(int currentPage, int pageSize) async {
    List<RecommendModel> data = [];
    if (isFirst) {
      isFirst = false;
      data.addAll(await RecommendService.instance.get());
      if (data.isEmpty) {
        data = await recommendRequest
            .recommendByPosition(RecommendPositionEnum.home.index);
        RecommendService.instance.put(data);
      } else {
        recommendRequest
            .recommendByPosition(RecommendPositionEnum.home.index)
            .then((value) {
          RecommendService.instance.put(value);
          if (list.isNotEmpty) {
            for (int i = 0; i < list.length; i++) {
              var recommend = list[i];
              var where = value.where(
                  (element) => element.recommendId == recommend.recommendId);
              if (where.isNotEmpty) {
                list[i] = where.first;
              }
            }
          }
        });
      }
      return data;
    }
    data = await recommendRequest
        .recommendByPosition(RecommendPositionEnum.home.index);
    RecommendService.instance.put(data);
    return data;
  }

  void onDetail(ItemModel item) {
    RecommendService.instance.onDetail(item);
  }

  void onOperate(int recommendType, int optType, String? optValue) async {
    if (optType == OptTypeEnum.refresh.index) {
      var data = await getData(1, pageSize);
      if (data.isNotEmpty) {
        var recommend = data
            .where((element) => element.recommendType == recommendType)
            .firstOrNull;
        if (recommend == null) {
          return;
        }
        for (var value in list) {
          if (value.recommendType == recommendType) {
            value.items = recommend.items;
            break;
          }
        }
      }
    } else {
      if (optValue != null) {
        AppNavigator.toContentPage(optValue);
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      // 进入应用时候不会触发该状态 应用程序处于可见状态，并且可以响应用户的输入事件。它相当于 Android 中Activity的onResume
      case AppLifecycleState.resumed:
        Log.d('==== 应用进入前台 ====');
        if (isAdvertLoading) {
          AdvertService.instance.buildScreenAdvert();
        }
        break;
      // 应用状态处于闲置状态，并且没有用户的输入事件，
      // 注意：这个状态切换到 前后台 会触发，所以流程应该是先冻结窗口，然后停止UI
      case AppLifecycleState.inactive:
        Log.d('==== 应用处于闲置状态，这种状态的应用应该假设他们可能在任何时候暂停 切换到后台会触发 ====');
        break;
      //当前页面即将退出
      case AppLifecycleState.detached:
        Log.d("==== 当前页面即将退出 ====");
        break;
      // 应用程序处于不可见状态
      case AppLifecycleState.paused:
        Log.d("==== 应用处于不可见状态 后台 ====");
        isAdvertLoading = !isAdvertLoading;
        break;
      case AppLifecycleState.hidden:
        Log.d("==== 应用处于隐藏状态 后台 ====");
        break;
    }
  }
}
