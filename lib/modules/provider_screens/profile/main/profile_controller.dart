import 'package:karigar/export.dart';

class ProfileController extends GetxController {
  ProviderData? _provider;
  ProviderData? get provider => _provider;
  set provider(ProviderData? value) {
    _provider = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  set errorMessage(String value) {
    _errorMessage = value;
    update();
  }

  bool _isUser = false;
  bool get isUser => _isUser;
  set isUser(bool value) {
    _isUser = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    if (args != null && args['providerId'] != null) {
      fetchProfile(args['providerId']);
      isUser = false; // Viewing someone else
    } else {
      // Fetch own profile
      fetchProfile(getUser()?.id);
      isUser = true; // Viewing self
    }
  }

  Future<void> fetchProfile(String? providerId) async {
    log('Calling API');
    try {
      isLoading = true;
      errorMessage = '';

      final result = await ProvidersRepository.getProfile(id: providerId);

      if (result['error'] == null) {
        provider = result['data'];
      } else {
        errorMessage = result['error'].toString();
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  void logout() {
    AuthRepository.localLogout();
  }
}
