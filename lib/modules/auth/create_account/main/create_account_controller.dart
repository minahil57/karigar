import 'package:karigar/export.dart';

class CreateAccountController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>(
    debugLabel: 'customer_form',
  );

  bool _isObscure = true;
  bool get isObscure => _isObscure;

  void togglePasswordVisibility() {
    _isObscure = !_isObscure;
    update(["password"]);
  }

  UserRole? _selectedValue = UserRole.customer;
  UserRole? get selectedValue => _selectedValue;

  void onChanged(UserRole? value) {
    _selectedValue = value;
    update(["tab", "form"]);
  }

  void submitSignUp() async {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }
    registerFormKey.currentState!.save();
    EasyLoading.show();
    final errorMessage = await AuthRepository.registerUser({
      "name": fullNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "role": _selectedValue!.apiValue,
    });
    log(errorMessage.toString());

    if (errorMessage == null) {
      EasyLoading.dismiss();
      Snackbars.success('Account Created Successfully');
      Get.offAllNamed(Routes.login);
    } else {
      EasyLoading.dismiss();
      Snackbars.error(errorMessage);
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
