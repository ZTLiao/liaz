import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/user/home/user_home_controller.dart';
import 'package:liaz/widgets/toolbar/user_photo.dart';
import 'package:remixicon/remixicon.dart';

class UserHomePage extends GetView<UserHomeController> {
  const UserHomePage({super.key});

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
              Visibility(
                visible: true,
                child: ListTile(
                  leading: const UserPhoto(
                    url: "",
                    size: 48,
                  ),
                  title: const Text(
                    "未登录",
                    style: TextStyle(height: 1.0),
                  ),
                  subtitle: const Text(
                    "点击前往登录",
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  onTap: () {},
                ),
              ),
              _buildCard(
                context,
                children: [
                  Visibility(
                    visible: true,
                    child: ListTile(
                      leading: const Icon(Remix.heart_line),
                      title: const Text("我的订阅"),
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
                      leading: const Icon(Remix.history_line),
                      title: const Text("浏览记录"),
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
                      title: const Text("我的评论"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              _buildCard(
                context,
                children: [
                  ListTile(
                    leading: const Icon(Remix.file_history_line),
                    title: const Text("本机记录"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Remix.star_line),
                    title: const Text("本机收藏"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Remix.download_line),
                    title: const Text("漫画下载"),
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
                  ListTile(
                    leading: const Icon(Remix.download_line),
                    title: const Text("小说下载"),
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
                    leading: Icon(
                        Get.isDarkMode ? Remix.moon_line : Remix.sun_line),
                    title: const Text("显示主题"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Remix.settings_line),
                    title: const Text("更多设置"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              _buildCard(
                context,
                children: [
                  ListTile(
                    leading: Icon(Remix.error_warning_line),
                    title: Text("免责声明"),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Remix.github_fill),
                    title: const Text("开源主页"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {

                    },
                  ),
                  ListTile(
                    leading: const Icon(Remix.upload_2_line),
                    title: const Text("检查更新"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: (){},
                  ),
                  ListTile(
                    leading: const Icon(Remix.information_line),
                    title: const Text("关于APP"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: (){},
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
