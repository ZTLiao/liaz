import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/modules/user/home/user_home_controller.dart';
import 'package:liaz/widgets/toolbar/user_photo.dart';
import 'package:remixicon/remixicon.dart';

class UserHomePage extends GetView<UserHomeController> {
  final int index;

  const UserHomePage(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : AppColor.backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Get.isDarkMode
            ? SystemUiOverlayStyle.light.copyWith(
                systemNavigationBarColor: Colors.transparent,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                systemNavigationBarColor: Colors.transparent,
              ),
        child: SafeArea(
          child: ListView(
            padding: AppStyle.edgeInsetsA4,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Visibility(
                      visible: true,
                      child: ListTile(
                        leading: const UserPhoto(
                          url: StrUtil.empty,
                          size: 48,
                        ),
                        title: const Text(
                          AppString.notLogin,
                          style: TextStyle(height: 7.0),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                    child: Icon(
                      Remix.settings_2_line,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              _buildCard(
                context,
                children: [
                  Visibility(
                    visible: true,
                    child: ListTile(
                      leading: const Icon(Remix.history_line),
                      title: const Text(AppString.browse),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: ListTile(
                      leading: const Icon(Remix.chat_smile_2_line),
                      title: const Text(AppString.comment),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Remix.star_line),
                    title: const Text(AppString.localComic),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Remix.download_line),
                    title: const Text(AppString.download),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: true,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: AppStyle.radius24,
                            ),
                            width: 20,
                            height: 20,
                            child: Center(
                              child: Text(
                                "12",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              _buildCard(
                context,
                children: [
                  ListTile(
                    leading: const Icon(Remix.settings_line),
                    title: const Text(AppString.settings),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Remix.github_fill),
                    title: const Text(AppString.messageBoard),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Remix.error_warning_line),
                    title: const Text(AppString.disclaimer),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Remix.upload_2_line),
                    title: const Text(AppString.checkUpdate),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Remix.information_line),
                    title: const Text(AppString.aboutAPP),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      margin: AppStyle.edgeInsetsH12.copyWith(top: 12),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: AppStyle.radius8,
        child: Theme(
          data: Theme.of(context).copyWith(
            listTileTheme: ListTileThemeData(
              shape: RoundedRectangleBorder(borderRadius: AppStyle.radius8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}
