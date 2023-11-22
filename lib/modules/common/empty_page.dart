import 'package:flutter/material.dart';
import 'package:liaz/app/app_color.dart';
import 'package:liaz/app/app_string.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text(AppString.appName,
            style: TextStyle(color: AppColor.gray19)),
      ),
    );
  }
}
