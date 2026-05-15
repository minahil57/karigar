import 'dart:async';

import 'package:karigar/export.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () async {
      if (await getAccessToken() == '') {
        Get.offAllNamed(Routes.login);
      } else {
        if (getUser()?.role == UserRole.customer.apiValue) {
          Get.offAllNamed(Routes.agent);
        } else {
          Snackbars.error("Invalid user role");
        }
      }
    });
  }
}
