import 'dart:async';

import 'package:karigar/export.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () async {
      log(await getAccessToken());
      if (await getAccessToken() == '') {
        Get.offAllNamed(Routes.onboarding);
      } else {
        if (getUser()?.role == UserRole.customer.apiValue) {
          Get.offAllNamed(Routes.agent);
        } else {
          Get.offAllNamed(Routes.providerApp);
        }
      }
    });
  }
}
