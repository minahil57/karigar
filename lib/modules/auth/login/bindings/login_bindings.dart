import 'package:karigar/export.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
