import 'package:karigar/export.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>(
    debugLabel: 'login_form',
  );

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

      final errorMessage = await AuthRepository.loginUser({
        'email': emailController.text,
        'password': passwordController.text,
      });
      if (errorMessage == null) {
        Snackbars.success('Login successful');
        EasyLoading.showSuccess('Login successful');
        log(await getAccessToken());

        log((getUser())!.toJson().toString());
        if (getUser()?.role == UserRole.customer.apiValue) {
          Get.offAllNamed(Routes.agent);
        } else {
          Get.offAllNamed(Routes.providerApp);
        }
      } else {
        Snackbars.error(errorMessage);
      }
    } catch (e) {
      EasyLoading.showError('Something went wrong');
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
