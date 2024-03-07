import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/sort_type_enum.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/modules/comic/download/comic_download_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/widgets/status/app_error_widget.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';

class ComicDownloadPage extends StatelessWidget {
  final ComicDetailModel comicDetail;

  final ComicDownloadController controller;

  ComicDownloadPage(this.comicDetail, {super.key})
      : controller = Get.put(
          ComicDownloadController(
            comicDetail: comicDetail,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          AppString.chooseChapter,
        ),
        actions: const [
          TextButton(
            onPressed: AppNavigator.toLocalDownloadPage,
            child: Text(
              AppString.downloadManage,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          EasyRefresh(
            header: const MaterialHeader(),
            onRefresh: () {},
            child: SingleChildScrollView(
              child: Padding(
                padding: AppStyle.edgeInsetsH8,
                child: _buildChapter(),
              ),
            ),
          ),
          Obx(
            () => Offstage(
              offstage: !controller.isPageLoading.value,
              child: const AppLoadingWidget(),
            ),
          ),
          Obx(
            () => Offstage(
              offstage: !controller.isPageError.value,
              child: AppErrorWidget(
                errorMsg: controller.errorMsg.value,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  onPressed: controller.selectAll,
                  icon: const Icon(
                    Icons.check_box_outlined,
                    size: 18,
                  ),
                  label: const Text(
                    AppString.selectAll,
                    maxLines: 1,
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  onPressed: controller.uncheck,
                  icon: const Icon(
                    Icons.check_box_outline_blank,
                    size: 18,
                  ),
                  label: const Text(
                    AppString.uncheck,
                    maxLines: 1,
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  onPressed: controller.onDownload,
                  icon: const Icon(
                    Icons.download_outlined,
                    size: 18,
                  ),
                  label: Obx(
                    () => Text(
                      '${AppString.downloadSelect}(${controller.chapterIds.length})',
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChapter() {
    var volumes = controller.comicDetail.volumes;
    return Column(
      children: volumes
          .map(
            (volume) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${(volume.volumeName != null && volume.volumeName!.isNotEmpty) ? volume.volumeName : AppString.serialize} （${AppString.total}${volume.chapters.length}${AppString.comicVolume}）',
                        style: Get.textTheme.titleSmall,
                      ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 14),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        volume.sortType.value =
                            volume.sortType.value == SortTypeEnum.desc.index
                                ? SortTypeEnum.asc.index
                                : SortTypeEnum.desc.index;
                        volume.sort();
                      },
                      icon: const Icon(
                        Icons.swap_vert,
                        size: 20,
                      ),
                      label: Text(
                          volume.sortType.value == SortTypeEnum.desc.index
                              ? AppString.desc
                              : AppString.asc),
                    ),
                  ],
                ),
                LayoutBuilder(
                  builder: (ctx, constraints) {
                    var count = constraints.maxWidth ~/ 160;
                    if (count < 3) count = 3;
                    return Obx(
                      () => MasonryGridView.count(
                        crossAxisCount: count,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            (volume.isShowMoreButton && !volume.isShowAll.value)
                                ? 15
                                : volume.chapters.length,
                        itemBuilder: (context, i) {
                          if (volume.isShowMoreButton &&
                              !volume.isShowAll.value &&
                              i == 14) {
                            return OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: controller.chapterIds.contains(
                                        volume.chapters[i].comicChapterId)
                                    ? Colors.cyan
                                    : Colors.grey,
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(fontSize: 14),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size.fromHeight(40),
                                side: BorderSide(
                                  color: controller.chapterIds.contains(
                                          volume.chapters[i].comicChapterId)
                                      ? Colors.cyan
                                      : Get.isDarkMode
                                          ? Colors.white
                                          : Colors.grey,
                                ),
                              ),
                              onPressed: () {
                                volume.isShowAll.value = true;
                              },
                              child: const Icon(Icons.arrow_drop_down),
                            );
                          }
                          return Obx(
                            () => OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: controller.chapterIds.contains(
                                        volume.chapters[i].comicChapterId)
                                    ? Colors.cyan
                                    : Colors.grey,
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(fontSize: 14),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size.fromHeight(40),
                                side: BorderSide(
                                  color: controller.chapterIds.contains(
                                          volume.chapters[i].comicChapterId)
                                      ? Colors.cyan
                                      : Get.isDarkMode
                                          ? Colors.white
                                          : Colors.grey,
                                ),
                              ),
                              onPressed: () {
                                controller.onSelect(
                                    volume.chapters[i].comicChapterId);
                              },
                              child: Text(
                                volume.chapters[i].chapterName,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
