import 'package:karigar/export.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
  }
}