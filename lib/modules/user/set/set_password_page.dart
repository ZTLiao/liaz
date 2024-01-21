import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/modules/user/set/set_password_controller.dart';

class SetPasswordPage extends StatelessWidget {
  final SetPasswordController controller;

  SetPasswordPage({super.key})
      : controller = Get.put<SetPasswordController>(SetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppString.setPassword),
      ),
      body: Obx(
        () => Column(
          children: [
            TextFormField(
              obscureText: controller.isShowPassword.value,
              controller: controller.password,
              decoration: InputDecoration(
                hintText: StrUtil.space + AppString.inputPassword,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
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
            TextFormField(
              obscureText: controller.isShowConfirmPassword.value,
              controller: controller.confirmPassword,
              decoration: InputDecoration(
                hintText: StrUtil.space + AppString.reConfirmPassword,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isShowConfirmPassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    controller.isShowConfirmPassword.value =
                        !controller.isShowConfirmPassword.value;
                  },
                ),
              ),
            ),
            AppStyle.vGap32,
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
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
          onPressed: controller.setPassword,
          child: const Text(
            AppString.submit,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
