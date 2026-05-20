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
  List<ProviderData>? selectedProviders;
  int selectedProviderIndex = 0;

  ProviderData? get selectedProvider {
    final providers = selectedProviders;
    if (providers == null || providers.isEmpty) return null;
    return providers[selectedProviderIndex.clamp(0, providers.length - 1)];
  }

  bool get hasSelectedProviders =>
      selectedProviders != null && selectedProviders!.isNotEmpty;

  bool get isClusterSelection =>
      selectedProviders != null && selectedProviders!.length > 1;

  Set<Marker> markers = {};

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    final currentLatLng = LatLng(position.latitude, position.longitude);

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLatLng, zoom: 15),
      ),
    );
  }

  void selectProvider(ProviderData provider) {
    selectedProviders = [provider];
    selectedProviderIndex = 0;
    update(['map']);
  }

  void selectProvidersAtLocation(List<ProviderData> providers) {
    selectedProviders = providers;
    selectedProviderIndex = 0;
    update(['map']);
  }

  void onCarouselPageChanged(int index) {
    selectedProviderIndex = index;
    update(['map']);
  }

  void dismissCard() {
    selectedProviders = null;
    selectedProviderIndex = 0;
    update(['map']);
  }

  void zoomIn() => mapController?.animateCamera(CameraUpdate.zoomIn());
  void zoomOut() => mapController?.animateCamera(CameraUpdate.zoomOut());

  Future<void> buildMarkers(List<ProviderData> providers) async {
    final groups = groupProvidersByLocation(providers);

    final placeholders = await Future.wait(
      groups.entries.map((entry) async {
        final group = entry.value;
        final first = group.first;
        final position = LatLng(first.lat.toDouble(), first.lng.toDouble());

        if (group.length == 1) {
          final icon = await buildPlaceholderMarker(title: first.businessName);
          return Marker(
            markerId: MarkerId(first.userId),
            position: position,
            icon: icon,
            onTap: () => selectProvider(first),
          );
        }

        final icon = await buildClusterPlaceholderMarker(
          title: first.businessName,
          count: group.length,
        );
        return Marker(
          markerId: MarkerId('cluster_${entry.key}'),
          position: position,
          icon: icon,
          onTap: () => selectProvidersAtLocation(group),
        );
      }),
    );

    markers = placeholders.toSet();
    update(['map']);

    final updated = <String, Marker>{
      for (final marker in placeholders) marker.markerId.value: marker,
    };

    await Future.wait(
      groups.entries.map((entry) async {
        final group = entry.value;
        final first = group.first;
        final position = LatLng(first.lat.toDouble(), first.lng.toDouble());

        if (group.length == 1) {
          final icon = await buildNetworkLogoMarker(
            first.avatar,
            title: first.businessName,
          );
          updated[first.userId] = Marker(
            markerId: MarkerId(first.userId),
            position: position,
            icon: icon,
            onTap: () => selectProvider(first),
          );
        } else {
          final icon = await buildNetworkClusterMarker(
            first.avatar,
            title: first.businessName,
            count: group.length,
          );
          updated['cluster_${entry.key}'] = Marker(
            markerId: MarkerId('cluster_${entry.key}'),
            position: position,
            icon: icon,
            onTap: () => selectProvidersAtLocation(group),
          );
        }

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
