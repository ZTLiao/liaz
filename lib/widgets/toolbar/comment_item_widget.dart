import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/app/utils/tool_util.dart';
import 'package:liaz/models/comment/comment_item_model.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';
import 'package:liaz/widgets/toolbar/user_photo.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class CommentItemWidget extends StatelessWidget {
  final CommentItemModel item;
  final Function(int)? onDetail;
  final Function(int)? onThumb;
  final Function(int)? onComment;

  var isExpand = RxBool(false);

  CommentItemWidget(
    this.item, {
    this.onDetail,
    this.onThumb,
    this.onComment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: AppStyle.edgeInsetsA12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                if (onDetail != null) {
                  onDetail!(item.userId);
                }
              },
              child: UserPhoto(
                url: item.avatar,
              ),
            ),
            AppStyle.hGap12,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.nickname,
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                AppStyle.vGap12,
                item.parents.isNotEmpty
                    ? (isExpand.value
                        ? createMasterParentComment(item.parents)
                        : createMasterComment(item))
                    : Container(),
                Text(
                  item.content,
                  style: Get.theme.textTheme.bodyMedium,
                ),
                item.paths.isNotEmpty
                    ? Padding(
                        padding: AppStyle.edgeInsetsT12,
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: item.paths.map<Widget>((path) {
                            return InkWell(
                              onTap: () {
                                ToolUtil.showImageViewer(
                                    item.paths.indexOf(path), item.paths);
                              },
                              child: NetImage(
                                path,
                                width: 100,
                                height: 100,
                                borderRadius: 4,
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : const SizedBox(),
                AppStyle.vGap12,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.content,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (onThumb != null) {
                          onThumb!(item.discussId);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Visibility(
                            visible: item.thumbNum > 0,
                            child: Padding(
                              padding: AppStyle.edgeInsetsL4,
                              child: Text(
                                '${item.thumbNum}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (onComment != null) {
                          onComment!(item.discussId);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.comment_outlined,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Visibility(
                            visible: item.discussNum > 0,
                            child: Padding(
                              padding: AppStyle.edgeInsetsL4,
                              child: Text(
                                '${item.discussNum}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget createMasterComment(CommentItemModel comment) {
    var list = comment.parents;
    if (list.isEmpty) return const SizedBox();
    List<Widget> items = [];
    if (list.length > 2) {
      items.add(createMasterCommentItem(list.first));
      items.add(InkWell(
        onTap: () {
          isExpand.value = true;
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4)),
          padding: AppStyle.edgeInsetsA8,
          child: Center(
              child: Text(
            '${AppString.clickExpand}${list.length - 2}${AppString.twig}${AppString.comment}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          )),
        ),
      ));
      items.add(AppStyle.vGap8);
      items.add(createMasterCommentItem(list.last));
    } else {
      for (var item in list) {
        items.add(createMasterCommentItem(item));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget createMasterParentComment(List<CommentItemModel> list) {
    List<Widget> items = list.map<Widget>((item) {
      return createMasterCommentItem(item);
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget createMasterCommentItem(CommentItemModel item) {
    return Padding(
      padding: AppStyle.edgeInsetsB8,
      child: InkWell(
        onTap: () {
          if (onComment != null) {
            onComment!(item.discussId);
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4)),
          padding: AppStyle.edgeInsetsA8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    alignment: ui.PlaceholderAlignment.middle,
                    child: InkWell(
                      child: Text(
                        item.nickname,
                        style:
                            TextStyle(color: Get.theme.colorScheme.secondary),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: "${StrUtil.semicolon} ${item.content}",
                    style: Get.theme.textTheme.bodyMedium,
                  )
                ]),
              ),
              item.paths.isNotEmpty
                  ? Padding(
                      padding: AppStyle.edgeInsetsT8,
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: item.paths.map<Widget>((path) {
                          return InkWell(
                            onTap: () {
                              ToolUtil.showImageViewer(
                                  item.paths.indexOf(path), item.paths);
                            },
                            child: NetImage(
                              path,
                              width: 100,
                              height: 100,
                              borderRadius: 4,
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
