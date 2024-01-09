import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/modules/user/home/user_home_controller.dart';
import 'package:liaz/services/user_service.dart';
import 'package:liaz/widgets/toolbar/user_photo.dart';

class UserHomePage extends GetView<UserHomeController> {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Get.isDarkMode ? Colors.black : AppColor.backgroundColor,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
        ),
      ),
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
            children: [
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListTile(
                        leading: UserPhoto(
                          url: controller.user.value.avatar,
                          size: 48,
                        ),
                        title: Text(
                          controller.user.value.nickname.isNotEmpty
                              ? controller.user.value.nickname
                              : AppString.notLogin,
                          style: const TextStyle(
                            height: 3.0,
                          ),
                        ),
                        trailing: const SizedBox(
                          width: 50,
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: UserService.instance.check,
                      ),
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
                      leading: const Icon(
                        Icons.work_history_outlined,
                      ),
                      title: const Text(AppString.browse),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.star_outline,
                    ),
                    title: const Text(AppString.localComic),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.download_outlined,
                    ),
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
                    leading: const Icon(
                      Icons.chat_outlined,
                    ),
                    title: const Text(AppString.messageBoard),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.contact_support_outlined,
                    ),
                    title: const Text(AppString.disclaimer),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.upload_outlined,
                    ),
                    title: const Text(AppString.checkUpdate),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                    ),
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
