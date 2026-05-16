import 'package:karigar/export.dart';

class HomeController extends GetxController {
  late ProviderData provider;
  List<ServiceRequestModel> serviceRequests = [];

  @override
  void onInit() {
    super.onInit();
    fetchProviders();
  }

  void fetchProviders() {
    provider = dummyProvider;
  }
}
