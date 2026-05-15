import 'dart:async';

import 'package:karigar/export.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.onboarding);
    });
  }
}