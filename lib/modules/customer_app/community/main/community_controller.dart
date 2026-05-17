import 'package:karigar/export.dart' hide Marker;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karigar/modules/customer_app/community/community_map_helpder.dart';

class CommunityController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  List<ProviderData> _providers = [];
  List<ProviderData> get providers => _providers;
  set providers(List<ProviderData> value) {
    _providers = value;
    update(['providers']);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update(['providers']);
  }

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  set errorMessage(String value) {
    _errorMessage = value;
    update(['providers']);
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
            .where(
              (p) =>
                  p.businessName.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ) ||
                  (p.specialty?.toString() ?? '').toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ),
            )
            .toList();

  bool _isMapView = true;
  bool get isMapView => _isMapView;

  void setMapView(bool value) {
    _isMapView = value;
    update(['view-type']);
  }

  GoogleMapController? mapController;
  ProviderData? selectedProvider;
  Set<Marker> markers = {};

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void selectProvider(ProviderData? provider) {
    selectedProvider = provider;
    update(['map']);
  }

  void dismissCard() => selectProvider(null);

  void zoomIn() => mapController?.animateCamera(CameraUpdate.zoomIn());
  void zoomOut() => mapController?.animateCamera(CameraUpdate.zoomOut());

  Future<void> buildMarkers(List<ProviderData> providers) async {
    // ignore: unnecessary_null_comparison
    final valid = providers.where((p) => p.lat != null).toList();

    final placeholders = await Future.wait(
      valid.map((provider) async {
        final icon = await buildPlaceholderMarker(title: provider.businessName);
        return Marker(
          markerId: MarkerId(provider.userId),
          position: LatLng(provider.lat.toDouble(), provider.lng.toDouble()),
          icon: icon,
          onTap: () => selectProvider(provider),
        );
      }),
    );

    markers = placeholders.toSet();
    update(['map']);

    final updated = <String, Marker>{
      for (final m in placeholders) m.markerId.value: m,
    };

    await Future.wait(
      valid.map((provider) async {
        final icon = await buildNetworkLogoMarker(
          provider.avatar,
          title: provider.businessName,
        );
        updated[provider.userId] = Marker(
          markerId: MarkerId(provider.userId),
          position: LatLng(provider.lat.toDouble(), provider.lng.toDouble()),
          icon: icon,
          onTap: () => selectProvider(provider),
        );
        markers = updated.values.toSet();
        update(['map']);
      }),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchProviders();
  }

  Future<void> fetchProviders() async {
    try {
      isLoading = true;
      errorMessage = '';

      providers = dummyProvidersList;

      final result = await ProvidersRepository.getProviders({});

      if (result['error'] == null) {
        providers = List<ProviderData>.from(result['data']);
        await buildMarkers(providers);
      } else {
        errorMessage = result['error'].toString();
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  void onSearchChanged(String value) {
    searchQuery = value;
    update(['providers']);
  }

  @override
  void onClose() {
    searchController.dispose();
    mapController?.dispose();

    super.onClose();
  }
}
