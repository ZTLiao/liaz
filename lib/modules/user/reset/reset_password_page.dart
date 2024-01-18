import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/user/reset/reset_password_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  final ResetPasswordController controller;

  ResetPasswordPage({super.key})
      : controller = Get.put(ResetPasswordController());

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
          child: Obx(
            () => Column(
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                buildTitle(),
                buildTitleLine(),
                const SizedBox(
                  height: 60,
                ),
                buildEmailTextField(),
                const SizedBox(
                  height: 30,
                ),
                Visibility(
                  visible: controller.isWaitVerify.value || controller.hasVerifyCode.value,
                  child: buildVerifyCodeTextField(context),
                ),
                Visibility(
                  visible: controller.hasVerifyCode.value,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      buildNewPasswordTextField(context),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Obx(
                  () => controller.hasVerifyCode.value
                      ? buildConfirmButton(context)
                      : buildVerifyCodeButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVerifyCodeButton(BuildContext context) {
    return Obx(
      () => Align(
        child: SizedBox(
          height: 45,
          width: 270,
          child: ElevatedButton(
            style: ButtonStyle(
              // 设置圆角
              shape: MaterialStateProperty.all(
                const StadiumBorder(
                  side: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
              ),
              //背景颜色
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black;
                  }
                  return Colors.cyan;
                },
              ),
            ),
            onPressed: controller.isWaitVerify.value
                ? controller.confirmVerifyCode
                : controller.sendVerifyCode,
            child: Text(
              controller.isWaitVerify.value
                  ? '${AppString.confirm}（${controller.countdown.value}）'
                  : AppString.sendVerifyCode,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildConfirmButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
            // 设置圆角
            shape: MaterialStateProperty.all(
              const StadiumBorder(
                side: BorderSide(
                  style: BorderStyle.none,
                ),
              ),
            ),
            //背景颜色
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.black;
                }
                return Colors.cyan;
              },
            ),
          ),
          onPressed: controller.resetPassword,
          child: const Text(
            AppString.confirm,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNewPasswordTextField(BuildContext context) {
    return Obx(
      () => TextFormField(
        obscureText: controller.isShowNewPassword.value,
        controller: controller.newPassword,
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
          labelText: AppString.newPassword,
          suffixIcon: IconButton(
            icon: Icon(
              controller.isShowNewPassword.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              controller.isShowNewPassword.value =
                  !controller.isShowNewPassword.value;
            },
          ),
        ),
      ),
    );
  }

  Widget buildVerifyCodeTextField(BuildContext context) {
    return TextFormField(
      controller: controller.verifyCode,
      decoration: const InputDecoration(
        labelText: AppString.verifyCode,
      ),
      validator: (v) {
        if (v!.isEmpty) {
          return AppString.verifyCodeEmptyError;
        }
        if (v.length < 6) {
          return AppString.verifyCodeShortError;
        }
        return null;
      },
    );
  }

  Widget buildEmailTextField() {
    return TextFormField(
      controller: controller.email,
      decoration: const InputDecoration(
        labelText: AppString.email,
      ),
      validator: (v) {
        if (v!.isEmpty) {
          return AppString.emailEmptyError;
        }
        return null;
      },
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
          AppString.resetEn,
          style: TextStyle(
            fontSize: 42,
          ),
        ),
      ),
    );
  }
}
