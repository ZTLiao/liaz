import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/modules/settings/comic/comic_settings_controller.dart';

class ComicSettingsView extends StatelessWidget {
  final ComicSettingsController controller;

  ComicSettingsView({super.key})
      : controller = Get.put(ComicSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black.withOpacity(0),
      body: SizedBox(),
    );
  }
}
