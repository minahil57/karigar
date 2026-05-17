import 'package:karigar/export.dart';

class HomeController extends GetxController {
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

  bool _isServiceLoading = false;
  bool get isServiceLoading => _isServiceLoading;
  set isServiceLoading(bool value) {
    _isServiceLoading = value;
     update(['serviceRequests']);
  }

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  set errorMessage(String value) {
    _errorMessage = value;
    update();
  }

   List<ServiceRequestModel> _serviceRequests = [];
  List<ServiceRequestModel> get serviceRequests => _serviceRequests;
  set serviceRequests(List<ServiceRequestModel> value) {
    _serviceRequests = value;
    update(['serviceRequests']);
  }

  @override
  void onInit() async {
    super.onInit();
    fetchProfile();
    fetchServiceRequests();
  }

  Future<void> fetchProfile() async {
    log('Calling API');
    try {
      log('Try');
      isLoading = true;
      errorMessage = '';

      final result = await ProvidersRepository.getProfile(
        id: getUser()?.id.toString(),
      );

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

  Future<void> fetchServiceRequests() async {
    try {
      isServiceLoading = true;
      serviceRequests = dummyServiceRequests;
      final result = await ProvidersRepository.getProviderBookings(
        id: getUser()?.id.toString(),
      );

      if (result['error'] == null) {

        serviceRequests = result['data'];
      } else {
        isServiceLoading = false;
        serviceRequests.clear();
        errorMessage = result['error'].toString();
      }
    } catch (e) {
      isServiceLoading = false;
      serviceRequests.clear();
      errorMessage = e.toString();
    } finally {
      isServiceLoading = false;
    }
  }
}
