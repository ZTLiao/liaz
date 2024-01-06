import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/search/home/search_home_controller.dart';
import 'package:liaz/widgets/toolbar/search_app_bar.dart';

class SearchHomePage extends StatelessWidget {
  final SearchHomeController controller;

  SearchHomePage({super.key}) : controller = Get.put(SearchHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: SearchAppBar(
          readOnly: false,
          autofocus: true,
          hintText: AppString.searchAlert,
          controller: controller.searchController,
          onTap: controller.onSearch,
        ),
      ),
      body: Column(
        children: [
          Visibility(
            visible: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: AppStyle.edgeInsetsH12.copyWith(bottom: 12),
                  child: Text(
                    AppString.historySearch,
                    style: TextStyle(
                      fontSize: 17,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.searchHistory.isNotEmpty,
                    child: Container(
                      padding: AppStyle.edgeInsetsH12.copyWith(bottom: 12),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete_forever,
                          size: 16,
                          color: AppColor.grey99,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.searchHistory.isNotEmpty,
              child: Padding(
                padding: AppStyle.edgeInsetsH12.copyWith(bottom: 12),
                child: Wrap(
                  spacing: 2,
                  runSpacing: 8,
                  children: controller.searchHistory
                      .map(
                        (e) => TextButton(
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: Get.isDarkMode
                                ? Colors.white10
                                : AppColor.greyf0,
                          ),
                          onPressed: () {
                            controller.searchKey(e.key);
                          },
                          child: Text(
                            e.key,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white70
                                  : Colors.black26,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          Offstage(
            offstage: false,
            child: Container(
              padding: AppStyle.edgeInsetsH12.copyWith(bottom: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.hotSearch,
                style: TextStyle(
                  fontSize: 17,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Offstage(
              offstage: false,
              child: ListView.separated(
                padding: AppStyle.edgeInsetsA12,
                separatorBuilder: (context, i) {
                  return Divider(
                    endIndent: 12,
                    indent: 12,
                    color: Colors.grey.withOpacity(.2),
                    height: 1,
                  );
                },
                itemCount: 100,
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: 40,
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(
                                "${i + 1}",
                                style: TextStyle(
                                    color: i < 3
                                        ? const Color.fromRGBO(242, 106, 95, 1)
                                        : const Color.fromRGBO(255, 134, 0, 1)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "关键字 ${i + 1}",
                                style: const TextStyle(color: Colors.cyan),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 64,
                            height: 24,
                            child: i < 5
                                ? const Icon(
                                    Icons.local_fire_department,
                                    size: 16,
                                    color: Color.fromRGBO(255, 148, 6, 1),
                                  )
                                : null, //搜索框图标
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
