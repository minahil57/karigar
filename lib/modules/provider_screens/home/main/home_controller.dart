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

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  set errorMessage(String value) {
    _errorMessage = value;
    update();
  }

  List<ServiceRequestModel> serviceRequests = [];

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    _loadMockServiceRequests();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading = true;
      errorMessage = '';

      final result = await ProvidersRepository.getProfile();

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

  void _loadMockServiceRequests() {
    serviceRequests = [
      ServiceRequestModel(
        title: 'Plumbing Repair',
        subtitle: 'Kitchen pipe leakage',
        location: 'Koramangala, Bengaluru',
        distance: '2.4 km',
        price: '₹1,250',
        timeAgo: 'Requested 10m ago',
        preferredTime: 'Today, 2:00 PM',
      ),
      ServiceRequestModel(
        title: 'Electrical Installation',
        subtitle: 'Ceiling fan installation',
        location: 'HSR Layout, Bengaluru',
        distance: '3.1 km',
        price: '₹950',
        timeAgo: 'Requested 25m ago',
        preferredTime: 'Tomorrow, 11:00 AM',
      ),
    ];
  }
}
