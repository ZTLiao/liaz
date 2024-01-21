import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/modules/settings/settings_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/user_service.dart';

class SettingsPage extends StatelessWidget {
  final controller = Get.put<SettingsController>(SettingsController());

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppString.settings),
      ),
      body: ListView(
        children: [
          Visibility(
            visible: Global.isUserLogin,
            child: const ListTile(
              title: Text(AppString.setPassword),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: AppNavigator.toSetPassword,
            ),
          ),
          const ListTile(
            title: Text('${AppString.general}${AppString.settings}'),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: AppNavigator.toGeneralSettings,
          ),
          const ListTile(
            title: Text('${AppString.comic}${AppString.settings}'),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: AppNavigator.toComicSettings,
          ),
          const ListTile(
            title: Text('${AppString.novel}${AppString.settings}'),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: AppNavigator.toNovelSettings,
          ),
          ListTile(
            title: const Text(AppString.checkUpdate),
            trailing: Text(
              Global.packageInfo.version,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: controller.checkUpdate,
          ),
          AppStyle.vGap32,
          Visibility(
            visible: Global.isUserLogin,
            child: buildLogoutButton(),
          ),
        ],
      ),
    );
  }

  Widget buildLogoutButton() {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              const StadiumBorder(
                side: BorderSide(
                  style: BorderStyle.none,
                ),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
                return Colors.white;
              },
            ),
          ),
          onPressed: UserService.instance.signOut,
          child: const Text(
            AppString.logoutAccount,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
