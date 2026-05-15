import 'package:karigar/export.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isObscure = true;
  bool get isObscure => _isObscure;

  void togglePasswordVisibility() {
    _isObscure = !_isObscure;
    update(["password"]);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void submitLogin() async {
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(Get.context!).unfocus();

    try {
      EasyLoading.show(status: 'Logging in...');

      AuthRepository.loginUser({
        'email': emailController.text,
        'password': passwordController.text,
      });

      await Future.delayed(const Duration(seconds: 1));

      EasyLoading.showSuccess("Login successful!");

      Snackbars.success('Login successful');
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
