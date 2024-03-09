import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/bucket_constant.dart';
import 'package:liaz/requests/file_item_request.dart';
import 'package:liaz/services/file_item_service.dart';
import 'package:liaz/widgets/toolbar/net_image.dart';

class UploadImageWidget extends StatelessWidget {
  final List<String> paths;
  final RxList<String> images = RxList<String>();

  final fileRequest = FileItemRequest();

  UploadImageWidget({required this.paths, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 10,
          runSpacing: 20,
          children: renderImgList(),
        ),
      ),
    );
  }

  List<Widget> renderImgList() {
    List<Widget> widgetList = [];
    for (int index = 0; index < images.length; index++) {
      var image = renderImg(index);
      widgetList.add(image);
    }
    if (images.length < 9) {
      //限制最多9张，达到9张隐藏按钮
      widgetList.add(addImgButton());
    }
    return widgetList;
  }

  Widget renderImg(int index) {
    return InkWell(
      child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Visibility(
            visible: false,
            replacement: Stack(
              children: [
                NetImage(
                  images[index],
                  fit: BoxFit.fill,
                  width: 100,
                  height: 100,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      width: 30,
                      height: 30,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      _deleteImg(index);
                    },
                  ),
                )
              ],
            ),
            child: Text(paths[index]),
          )),
    );
  }

  Widget addImgButton() {
    //添加图片的按钮
    return InkWell(
      onTap: _openGallery,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              width: 2,
              color: AppColor.grey99,
            )),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 35,
              color: AppColor.grey99,
            ),
          ],
        ),
      ),
    );
  }

  //选择相册照片&上传
  void _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var path = await fileRequest.upload(
          BucketConstant.discuss, File(pickedFile.path));
      if (path.isNotEmpty) {
        paths.add(path);
        images.add(await FileItemService.instance.getObject(path));
      }
    }
  }

  //删除图片
  void _deleteImg(int index) {
    paths.removeAt(index);
    images.removeAt(index);
  }
}
