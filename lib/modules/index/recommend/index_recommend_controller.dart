import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/recommend_type_enum.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/models/recommend/recommend_item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';

class IndexRecommendController extends BasePageController<RecommendModel> {
  @override
  Future<List<RecommendModel>> getData(int currentPage, int pageSize) {
    var list = [
      RecommendModel(
        recommendId: 1,
        title: 'BANNER',
        type: RecommendTypeEnum.banner.index,
        items: [
          RecommendItemModel(
            recommendItemId: 1,
            title: '十月新番！来嘞！',
            showValue:
                'https://images.idmzj.com/tuijian/750_480/230915shiyuexinfantj1.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.idmzj.com/tuijian/750_480/230915shiyuexinfantj1.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 2,
            title: '十月新番！来嘞！',
            showValue:
                'https://images.idmzj.com/tuijian/750_480/230915shiyuexinfantj1.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.idmzj.com/tuijian/750_480/230915shiyuexinfantj1.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 3,
            title: '十月新番！来嘞！',
            showValue:
                'https://images.idmzj.com/tuijian/750_480/230915shiyuexinfantj1.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.idmzj.com/tuijian/750_480/230915shiyuexinfantj1.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '十月新番！来嘞！',
            showValue:
                'https://images.idmzj.com/tuijian/750_480/230915shiyuexinfantj1.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.idmzj.com/tuijian/750_480/230915shiyuexinfantj1.jpg',
          ),
        ],
      )
    ];
    return Future(() => list);
  }
}
