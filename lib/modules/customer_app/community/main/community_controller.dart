import 'package:karigar/export.dart';

class CommunityController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  List<ProviderData> _providers = [];
  List<ProviderData> get providers => _providers;
  set providers(List<ProviderData> value) {
    _providers = value;
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

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    _searchQuery = value;
    update();
  }

  List<ProviderData> get filteredProviders => searchQuery.isEmpty
      ? providers
      : providers
          .where((p) =>
              p.businessName.toLowerCase().contains(searchQuery.toLowerCase()) ||
              (p.specialty?.toString() ?? '')
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();

  @override
  void onInit() {
    super.onInit();
    fetchProviders();
  }

  Future<void> fetchProviders() async {
    isLoading = true;
    errorMessage = '';

    providers = dummyProvidersList;

    final result = await ProvidersRepository.getProviders({});

    if (result['error'] == null) {
      providers = result['data'];
    } else {
      errorMessage = result['error'];
    }

    isLoading = false;
  }

  void onSearchChanged(String value) {
    searchQuery = value;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
