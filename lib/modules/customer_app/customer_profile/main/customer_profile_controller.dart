import 'package:karigar/export.dart';

class CustomerProfileController extends GetxController {
  UserModel? user;

  @override
  void onInit() {
    super.onInit();
    user = LocalStorage.getUser();
  }

  void logout() {
    AuthRepository.localLogout();
  }

  void deleteAccount() {
    // Implement delete account logic here
    // For now, we just logout
    AuthRepository.localLogout();
  }
}