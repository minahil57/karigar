import 'package:karigar/export.dart' hide Marker;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommunityMapView extends StatelessWidget {
  const CommunityMapView({super.key});

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: GetBuilder<CommunityController>(
        id: 'map',
        builder: (ctrl) {
          return Stack(
            fit: StackFit.expand,
            children: [
              GoogleMap(
                initialCameraPosition: _initialPosition,
                mapType: MapType.normal,

                /// Your custom markers only
                markers: ctrl.markers,

                onMapCreated: ctrl.onMapCreated,
                onTap: (_) => ctrl.dismissCard(),

                /// Current location
                myLocationEnabled: true,
                myLocationButtonEnabled: false,

                /// Disable default map UI
                buildingsEnabled: false,
                indoorViewEnabled: false,
                trafficEnabled: false,
                mapToolbarEnabled: false,
                compassEnabled: false,
                zoomControlsEnabled: false,

                /// Remove default POIs like bus stops, shops, etc.
                style: '''
[
  {
    "featureType": "poi",
    "stylers": [
      { "visibility": "off" }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      { "visibility": "off" }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      { "visibility": "off" }
    ]
  }
]
''',
              ),

              Positioned(
                right: 16,
                bottom: ctrl.hasSelectedProviders
                    ? (ctrl.isClusterSelection ? 340 : 230)
                    : 40,
                child: const ZoomButtons(),
              ),

              const Positioned(top: 16, right: 16, child: ViewToggleButton()),

              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                bottom: ctrl.hasSelectedProviders ? 24 : -360,
                left: 16,
                right: 16,
                child: ctrl.hasSelectedProviders
                    ? ctrl.isClusterSelection
                        ? ProviderMapCarousel(
                            providers: ctrl.selectedProviders!,
                            initialIndex: ctrl.selectedProviderIndex,
                            onDismiss: ctrl.dismissCard,
                            onPageChanged: ctrl.onCarouselPageChanged,
                          )
                        : ProviderMapCard(
                            provider: ctrl.selectedProvider!,
                            onDismiss: ctrl.dismissCard,
                          )
                    : const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}
