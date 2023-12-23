import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/user/login/user_login_controller.dart';

class UserLoginPage extends StatelessWidget {
  final UserLoginController controller;

  UserLoginPage({super.key}) : controller = Get.put(UserLoginController());

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
              buildEmailTextField(),
              const SizedBox(
                height: 30,
              ),
              buildPasswordTextField(context),
              buildForgetPasswordText(context),
              const SizedBox(
                height: 60,
              ),
              buildLoginButton(context),
              const SizedBox(
                height: 40,
              ),
              buildOtherLoginText(),
              buildOtherMethod(context),
              buildRegisterText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRegisterText(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(AppString.noAccount),
            GestureDetector(
              child: const Text(
                AppString.clickRegister,
                style: TextStyle(
                  color: Colors.cyan,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget buildOtherMethod(context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: controller.thirdLogin
          .map((item) => Builder(builder: (context) {
                return IconButton(
                    icon: Icon(
                      item['icon'],
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${item['title']}登录'),
                            action: SnackBarAction(
                              label: '取消',
                              onPressed: () {},
                            )),
                      );
                    });
              }))
          .toList(),
    );
  }

  Widget buildOtherLoginText() {
    return const Center(
      child: Text(
        AppString.thirdLogin,
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
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
          child: const Text(
            AppString.login,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: AppStyle.edgeInsetsT8,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
          child: const Text(
            AppString.forgetPassword,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordTextField(BuildContext context) {
    return TextFormField(
        obscureText: controller.isObscure, // 是否显示文字
        onSaved: (v) => controller.password = v!,
        validator: (v) {
          if (v!.isEmpty) {
            return '请输入密码';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: AppString.password,
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
              onPressed: () {},
            )));
  }

  Widget buildEmailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: AppString.username,
      ),
      validator: (v) {
        return null;
      },
      onSaved: (v) => controller.email = v!,
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
        ));
  }

  Widget buildTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: const Padding(
          padding: AppStyle.edgeInsetsA8,
          child: Text(
            AppString.login,
            style: TextStyle(
              fontSize: 42,
            ),
          )),
    );
  }
}
