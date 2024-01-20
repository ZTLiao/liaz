import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/enums/gender_enum.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/user_service.dart';

class UserDetailController extends GetxController {
  Rx<User> user = Rx<User>(User.empty());

  RxString nickname = RxString(StrUtil.empty);

  RxString phone = RxString(StrUtil.empty);

  RxString email = RxString(StrUtil.empty);

  RxInt gender = RxInt(0);

  RxString description = RxString(StrUtil.empty);

  TextEditingController nicknameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  UserDetailController() {
    UserService.instance.get().then((value) {
      if (value != null) {
        user.value = User.fromJson(value.toJson());
        nicknameController.text = value.nickname;
        nickname.value = value.nickname;
        phoneController.text = value.phone;
        phone.value = value.phone;
        emailController.text = value.email;
        email.value = value.email;
        gender.value = value.gender;
        descriptionController.text = value.description;
        description.value = value.description;
      }
    });
  }

  void saveUser() {
    UserService.instance.updateUser(user.value.userId, nickname.value,
        phone.value, email.value, gender.value, description.value);
  }

  void editNickname() {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).viewInsets.bottom + 65,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: nicknameController,
              onSubmitted: (e) {
                nickname.value = nicknameController.text;
                AppNavigator.closePage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void editPhone() {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).viewInsets.bottom + 65,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: AppString.pleaseInputValidPhone,
              ),
              onSubmitted: (e) {
                phone.value = phoneController.text;
                AppNavigator.closePage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void editEmail() {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).viewInsets.bottom + 65,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: emailController,
              decoration: const InputDecoration(
                hintText: AppString.pleaseInputValidEmail,
              ),
              onSubmitted: (e) {
                email.value = emailController.text;
                AppNavigator.closePage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void editGender() {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      builder: (context) => SizedBox(
        height: 140,
        child: ListView(
          children: [
            ListTile(
              title: const Text(AppString.male),
              onTap: () {
                gender.value = GenderEnum.male.index;
                AppNavigator.closePage();
              },
            ),
            ListTile(
              title: const Text(AppString.female),
              onTap: () {
                gender.value = GenderEnum.female.index;
                AppNavigator.closePage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void editDescription() {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).viewInsets.bottom + 200,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: AppString.specialMine,
              ),
              minLines: 4,
              maxLines: 6,
              onSubmitted: (e) {
                description.value = descriptionController.text;
                AppNavigator.closePage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
