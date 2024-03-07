import 'package:fuiopia/constants/constants.dart';

import 'package:flutter/material.dart';
import 'package:fuiopia/configs/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_CONST.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IMAGE_CONST.APP_LOGO,
              width: SizeConfig.defaultSize * 15,
              height: SizeConfig.defaultSize * 15,
            ),
            SizedBox(height: SizeConfig.defaultSize),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
