import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/user/home/user_home_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
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
          margin: AppStyle.edgeInsetsH8.copyWith(top: 12),
          child: const IconButton(
            onPressed: AppNavigator.toSettings,
            icon: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
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
                      () => Container(
                        margin: AppStyle.edgeInsetsH12.copyWith(top: 12),
                        child: ListTile(
                          leading: UserPhoto(
                            url: controller.avatar.value,
                            size: 48,
                          ),
                          title: Text(
                            controller.nickname.value.isNotEmpty
                                ? controller.nickname.value
                                : AppString.notLogin,
                            style: const TextStyle(
                              height: 3.0,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                          onTap: controller.onUserDetail,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _buildCard(
                context,
                children: [
                  Obx(
                    () => Visibility(
                      visible: controller.user.value.userId != 0,
                      child: const ListTile(
                        leading: Icon(
                          Icons.work_history_outlined,
                        ),
                        title: Text(AppString.browse),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                        onTap: AppNavigator.toBrowseHistory,
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.download_outlined,
                    ),
                    title: Text(AppString.localDownload),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: AppNavigator.toLocalDownloadPage,
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.chat_outlined,
                    ),
                    title: Text(AppString.messageBoard),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: AppNavigator.toMessageBoard,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.share,
                    ),
                    title: const Text(AppString.shareAPP),
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
