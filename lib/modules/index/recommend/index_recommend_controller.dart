import 'package:liaz/app/controller/base_page_controller.dart';
import 'package:liaz/app/enums/opt_type_enum.dart';
import 'package:liaz/app/enums/show_type_enum.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/models/recommend/recommend_item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';

class IndexRecommendController extends BasePageController<RecommendModel> {
  @override
  Future<List<RecommendModel>> getData(int currentPage, int pageSize) {
    var list = [
      RecommendModel(
        recommendId: 1,
        title: 'BANNER',
        showType: ShowTypeEnum.banner.index,
        showTitle: YesOrNo.no,
        optType: OptTypeEnum.refresh.index,
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
      ),
      RecommendModel(
        recommendId: 1,
        title: '最近更新',
        showType: ShowTypeEnum.none.index,
        showTitle: YesOrNo.yes,
        optType: OptTypeEnum.refresh.index,
        items: [
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 4,
            title: '最弱的我用“穿墙bug”变强',
            subTitle: '作者:畑优以/北川ニキタ',
            showValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/4/zuiruodewoyongchuanqiangbugbianqiang230720.jpg',
          ),
        ],
      ),
      RecommendModel(
        recommendId: 3,
        title: '恋爱四格',
        showType: ShowTypeEnum.twoGrid.index,
        showTitle: YesOrNo.yes,
        optType: OptTypeEnum.more.index,
        items: [
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '恋爱四格小剧场',
            showValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/tuijian/320_170/160802lianaisige.jpg',
          ),
        ],
      ),
      RecommendModel(
        recommendId: 2,
        title: '热门连载',
        showType: ShowTypeEnum.threeGrid.index,
        showTitle: YesOrNo.yes,
        optType: OptTypeEnum.refresh.index,
        items: [
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
                'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
          RecommendItemModel(
            recommendItemId: 1,
            title: '天才魔女没魔了',
            subTitle: '作者:辻岛もと',
            showValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
            skipType: SkipTypeEnum.h5.index,
            skipValue:
            'https://images.dmzj.com/webpic/14/tiancaimonvmeimole20230519.jpg',
          ),
        ],
      ),

    ];
    return Future(() => list);
  }
}
