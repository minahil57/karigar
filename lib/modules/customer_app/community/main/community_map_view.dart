import 'package:karigar/export.dart' hide Marker;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommunityMapView extends StatelessWidget {
  const CommunityMapView({super.key});

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14          ,
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
                markers: ctrl.markers,
                onMapCreated: ctrl.onMapCreated,
                onTap: (_) => ctrl.dismissCard(),
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),

              Positioned(
                right: 16,
                bottom: ctrl.selectedProvider != null ? 230 : 40,
                child: ZoomButtons(),
              ),

              const Positioned(top: 16, right: 16, child: ViewToggleButton()),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                bottom: ctrl.selectedProvider != null ? 24 : -260,
                left: 16,
                right: 16,
                child: ctrl.selectedProvider != null
                    ? ProviderMapCard(
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
