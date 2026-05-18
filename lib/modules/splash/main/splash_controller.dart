import 'package:karigar/export.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Request location permission on startup
    await LocationService.requestLocationPermission();

    // Ensure the splash screen is visible for a brief moment for a smooth transition
    await Future.delayed(const Duration(seconds: 2));

    log(await getAccessToken());
    if (await getAccessToken() == '') {
      Get.offAllNamed(Routes.onboarding);
    } else {
      if (getUser()?.role == UserRole.customer.apiValue) {
        Get.offAllNamed(Routes.agent);
      } else {
        if (getUser()!.isProfileCompleted == false) {
          Get.offAllNamed(Routes.providerApp);
        } else {
          Get.offAllNamed(Routes.providerApp);
        }
      }
    }
  }
}
