import 'dart:convert';

import 'package:get/get.dart';
import 'package:liaz/app/constants/local_storage.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/local_storage_service.dart';
import 'package:liaz/services/novel_service.dart';

class RecommendService extends GetxService {
  static RecommendService get instance {
    if (Get.isRegistered<RecommendService>()) {
      return Get.find<RecommendService>();
    }
    return Get.put(RecommendService());
  }

  void onDetail(ItemModel item) {
    var skipType = item.skipType;
    var skipValue = item.skipValue;
    var objId = item.objId;
    Log.d("skipType : $skipType, skipValue : $skipValue, objId : $objId");
    //H5
    if (SkipTypeEnum.h5.index == skipType) {
      if (skipValue != null && skipValue.isNotEmpty) {
        AppNavigator.toWebView(skipValue);
      }
    } else if (SkipTypeEnum.comic.index == skipType ||
        SkipTypeEnum.novel.index == skipType) {
      if (skipValue != null && skipValue.isNotEmpty && int.parse(skipValue) != 0) {
        var isUpgrade = item.isUpgrade;
        if (isUpgrade != null && isUpgrade == YesOrNo.yes) {
          //漫画
          if (SkipTypeEnum.comic.index == skipType) {
            ComicService.instance.toReadChapter(int.parse(skipValue));
            //小说
          } else if (SkipTypeEnum.novel.index == skipType) {
            NovelService.instance.toReadChapter(int.parse(skipValue));
          }
          return;
        }
      }
      if (objId != null && objId != 0) {
        //漫画
        if (SkipTypeEnum.comic.index == skipType) {
          ComicService.instance.toComicDetail(objId);
          //小说
        } else if (SkipTypeEnum.novel.index == skipType) {
          NovelService.instance.toNovelDetail(objId);
        }
      }
    } else {
      if (skipValue != null && skipValue.isNotEmpty) {
        AppNavigator.toContentPage(skipValue);
      }
    }
  }

  void put(List<RecommendModel> list) {
    if (list.isEmpty) {
      return;
    }
    LocalStorageService.instance
        .setValue(LocalStorage.kIndexRecommend, list.toString());
  }

  void clear() {
    LocalStorageService.instance.removeValue(LocalStorage.kIndexRecommend);
  }

  Future<List<RecommendModel>> get() async {
    await LocalStorageService.instance.init();
    var list = LocalStorageService.instance
        .getValue<String>(LocalStorage.kIndexRecommend, StrUtil.emptyList);
    List<RecommendModel> data = [];
    if (list.isNotEmpty) {
      for (var model in json.decode(list)) {
        data.add(RecommendModel.fromJson(model));
      }
    }
    return data;
  }
}
