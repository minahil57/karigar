import 'package:karigar/export.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return Scaffold(
      body: Center(
        child: CustomAssetsImage(
          imagePath: AppImages.logo,
          height: 250,
          width: double.infinity,
        ),
      ),
    );
  }
}
