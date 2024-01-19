import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/modules/user/detail/user_detail_controller.dart';
import 'package:liaz/widgets/toolbar/user_photo.dart';

class UserDetailPage extends StatelessWidget {
  final UserDetailController controller;

  UserDetailPage({super.key}) : controller = Get.put(UserDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(AppString.editUser),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(.2),
            width: 1,
          ),
        ),
      ),
      body: Obx(
        () => SafeArea(
          child: ListView(
            children: [
              ListTile(
                title: Text('头像:'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                title: Text('昵称:'),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                title: Text('生日:'),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                title: Text('描述:'),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
