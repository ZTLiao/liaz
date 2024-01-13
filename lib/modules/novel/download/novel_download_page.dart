import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/modules/novel/download/novel_download_controller.dart';
import 'package:liaz/widgets/status/app_error_widget.dart';
import 'package:liaz/widgets/status/app_loading_widget.dart';

class NovelDownloadPage extends StatelessWidget {
  final NovelDetailModel novelDetail;

  final NovelDownloadController controller;

  NovelDownloadPage(this.novelDetail, {super.key})
      : controller = Get.put(NovelDownloadController(
          novelDetail: novelDetail,
        ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          AppString.chooseChapter,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
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
                onRefresh: () {},
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check_box_outlined,
                    size: 20,
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
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check_box_outline_blank,
                    size: 20,
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
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.download_outlined,
                    size: 20,
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
    var volumes = controller.novelDetail.volumes;
    return Column(
      children: volumes
          .map((volume) => Column(
                children: [
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      '${(volume.volumeName != null && volume.volumeName!.isNotEmpty) ? volume.volumeName : AppString.serialize} （${AppString.total}${volume.chapters.length}${AppString.volume}）',
                    ),
                    tilePadding: AppStyle.edgeInsetsH4,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: volume.chapters.length,
                        itemBuilder: (context, i) {
                          var item = volume.chapters[i];
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(
                                  () => Text(
                                    item.chapterName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                      color: controller.chapterIds
                                              .contains(item.novelChapterId)
                                          ? Colors.cyan
                                          : null,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${AppString.at} ${DateUtil.formatDateTimeMinute(item.updatedAt)} ${AppString.publish}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColor.grey99,
                                  ),
                                ),
                              ],
                            ),
                            contentPadding: AppStyle.edgeInsetsA4,
                            visualDensity: const VisualDensity(
                              vertical: VisualDensity.minimumDensity,
                            ),
                            onTap: () {},
                          );
                        },
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(.2),
                    height: 1.0,
                  ),
                ],
              ))
          .toList(),
    );
  }
}
