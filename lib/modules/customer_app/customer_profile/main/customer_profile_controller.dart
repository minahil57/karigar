import 'package:karigar/export.dart';

class CustomerProfileController extends GetxController {
  UserModel? user;
  String currentAddress = 'Fetching location...';
  bool isLoadingAddress = false;

  @override
  void onInit() {
    super.onInit();
    user = LocalStorage.getUser();
    fetchCurrentAddress();
  }

  Future<void> fetchCurrentAddress() async {
    isLoadingAddress = true;
    update();

    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        currentAddress = await LocationService.getAddressFromLatLng(
          position.latitude,
          position.longitude,
        );
      } else {
        currentAddress = 'Unable to fetch current location coordinates.';
      }
    } catch (e) {
      currentAddress = 'Error fetching location: ${e.toString()}';
    } finally {
      isLoadingAddress = false;
      update();
    }
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