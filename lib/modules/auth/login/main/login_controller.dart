import 'package:karigar/export.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>(
    debugLabel: 'login_form',
  );

  final RxBool isObscure = true.obs;

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
    update(["password"]);
  }


  void submitLogin() async {
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(Get.context!).unfocus();

    try {
      EasyLoading.show(status: AppStrings.loggingIn);

      final errorMessage = await AuthRepository.loginUser({
        'email': emailController.text,
        'password': passwordController.text,
      });
      if (errorMessage == null) {
        Snackbars.success(AppStrings.loginSuccessful);
        EasyLoading.showSuccess(AppStrings.loginSuccessful);

        log((getUser())!.toJson().toString());
        if (getUser()?.role == UserRole.customer.apiValue) {
          Get.offAllNamed(Routes.agent);
        } else {
          if (getUser()?.isProfileCompleted == true) {
            Get.offAllNamed(Routes.providerApp);
          } else {
            Get.offAllNamed(Routes.completeProfile);
          }
        }
      } else {
        Snackbars.error(errorMessage);
      }
    } catch (e) {
      EasyLoading.showError(AppStrings.somethingWentWrong);
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
