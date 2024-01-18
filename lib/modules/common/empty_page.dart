import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_asset.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Image.asset(
          AppAsset.imageLogo,
          height: 80,
        ),
      ),
    );
  }
}
