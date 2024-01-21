import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/gender_enum.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/modules/user/detail/user_detail_controller.dart';
import 'package:liaz/widgets/toolbar/user_photo.dart';

class UserDetailPage extends StatelessWidget {
  final UserDetailController controller;

  UserDetailPage({super.key}) : controller = Get.put(UserDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(AppString.userDetail),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              ListTile(
                leading:
                    const Text('${AppString.userAvatar}${StrUtil.semicolon}'),
                trailing: UserPhoto(
                  url: controller.user.value.avatar,
                ),
              ),
              ListTile(
                leading:
                    const Text('${AppString.username}${StrUtil.semicolon}'),
                trailing: Text(
                  controller.user.value.username,
                ),
              ),
              ListTile(
                leading:
                    const Text('${AppString.nickname}${StrUtil.semicolon}'),
                title: Text(controller.nickname.value),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: controller.editNickname,
              ),
              ListTile(
                leading: const Text('${AppString.phone}${StrUtil.semicolon}'),
                title: Text(controller.phone.value),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: controller.editPhone,
              ),
              ListTile(
                leading: const Text('${AppString.email}${StrUtil.semicolon}'),
                title: Text(controller.email.value),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: controller.editEmail,
              ),
              ListTile(
                leading: const Text('${AppString.gender}${StrUtil.semicolon}'),
                title: Text(controller.gender.value == GenderEnum.male.index
                    ? AppString.male
                    : AppString.female),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: controller.editGender,
              ),
              ListTile(
                leading:
                    const Text('${AppString.description}${StrUtil.semicolon}'),
                title: Text(
                  controller.user.value.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: controller.editDescription,
              ),
              ListTile(
                leading:
                    const Text('${AppString.ipAddress}${StrUtil.semicolon}'),
                trailing: Text(
                  '${controller.user.value.country} ${controller.user.value.province} ${controller.user.value.city}',
                ),
              ),
              AppStyle.vGap60,
              buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSaveButton() {
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
                if (states.contains(MaterialState.pressed)) {
                  return Colors.black;
                }
                return Colors.cyan;
              },
            ),
          ),
          onPressed: controller.saveUser,
          child: const Text(
            AppString.save,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
