import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_asset.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/gender_enum.dart';
import 'package:liaz/modules/user/register/user_register_controller.dart';

class UserRegisterPage extends StatelessWidget {
  final UserRegisterController controller;

  UserRegisterPage({super.key})
      : controller = Get.put(UserRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: kToolbarHeight,
              ),
              buildTitle(),
              buildTitleLine(),
              const SizedBox(
                height: 60,
              ),
              buildAvatarField(),
              const SizedBox(
                height: 30,
              ),
              buildGenderButton(),
              buildNicknameTextField(),
              const SizedBox(
                height: 30,
              ),
              buildUsernameTextField(),
              const SizedBox(
                height: 30,
              ),
              buildPasswordTextField(),
              const SizedBox(
                height: 60,
              ),
              buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAvatarField() {
    return Center(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Obx(
              () => GestureDetector(
                onTap: controller.setAvatar,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColor.greyf0,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: controller.image.value != null
                        ? FileImage(controller.image.value!)
                        : null,
                    child: controller.image.value == null
                        ? ClipOval(
                            child: Image.asset(
                              AppAsset.imageLogo,
                              fit: BoxFit.contain,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 40,
                left: 40,
              ),
              child: const CircleAvatar(
                radius: 10,
                backgroundColor: AppColor.greyf0,
                child: CircleAvatar(
                  radius: 10,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 16,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUsernameTextField() {
    return TextFormField(
      controller: controller.username,
      decoration: const InputDecoration(
        labelText: AppString.username,
      ),
      validator: (v) {
        if (v!.isEmpty) {
          return AppString.usernameEmptyError;
        }
        return null;
      },
    );
  }

  Widget buildNicknameTextField() {
    return TextFormField(
      controller: controller.nickname,
      decoration: const InputDecoration(
        labelText: AppString.nickname,
      ),
      validator: (v) {
        if (v!.isEmpty) {
          return AppString.nicknameEmptyError;
        }
        return null;
      },
    );
  }

  Widget buildPasswordTextField() {
    return Obx(
      () => TextFormField(
        obscureText: controller.isShowPassword.value,
        controller: controller.password,
        validator: (v) {
          if (v!.isEmpty) {
            return AppString.passwordEmptyError;
          }
          if (v.length < 6) {
            return AppString.passwordShortError;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: AppString.password,
          suffixIcon: IconButton(
            icon: Icon(
              controller.isShowPassword.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              controller.isShowPassword.value =
                  !controller.isShowPassword.value;
            },
          ),
        ),
      ),
    );
  }

  Widget buildRegisterButton() {
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
          onPressed: controller.signUp,
          child: const Text(
            AppString.register,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitleLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40,
          height: 2,
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: const Padding(
        padding: AppStyle.edgeInsetsA8,
        child: Text(
          AppString.registerEn,
          style: TextStyle(
            fontSize: 42,
          ),
        ),
      ),
    );
  }

  Widget buildGenderButton() {
    return Row(
      children: [
        Obx(
          () => Expanded(
            child: IconButton(
              onPressed: () {
                controller.gender.value = GenderEnum.male.index;
              },
              icon: Icon(
                Icons.male,
                color: controller.gender.value == GenderEnum.male.index
                    ? Colors.cyan
                    : (Get.isDarkMode ? Colors.white70 : Colors.black45),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (controller.gender.value == GenderEnum.male.index) {
                      return Get.isDarkMode ? AppColor.greyf0 : AppColor.grey99;
                    }
                    return Get.isDarkMode ? AppColor.black33 : AppColor.greyf0;
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Obx(
          () => Expanded(
            child: IconButton(
              onPressed: () {
                controller.gender.value = GenderEnum.female.index;
              },
              icon: Icon(
                Icons.female,
                color: controller.gender.value == GenderEnum.female.index
                    ? Colors.cyan
                    : (Get.isDarkMode ? Colors.white70 : Colors.black45),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (controller.gender.value == GenderEnum.female.index) {
                      return Get.isDarkMode ? AppColor.greyf0 : AppColor.grey99;
                    }
                    return Get.isDarkMode ? AppColor.black33 : AppColor.greyf0;
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
