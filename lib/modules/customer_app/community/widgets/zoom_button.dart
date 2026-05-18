import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karigar/export.dart'hide Marker;

class ZoomButtons extends StatelessWidget {
  const ZoomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CommunityController>();

    return Container(
      decoration: BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: kcBlackColor.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _zoomBtn(
            icon: Icons.add,
            onTap: () =>
                ctrl.mapController?.animateCamera(CameraUpdate.zoomIn()),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          Container(height: 1, width: 44, color: kcborderColor),
          _zoomBtn(
            icon: Icons.remove,
            onTap: () =>
                ctrl.mapController?.animateCamera(CameraUpdate.zoomOut()),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _zoomBtn({
    required IconData icon,
    required VoidCallback onTap,
    required BorderRadius borderRadius,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, size: 22, color: kcBlackColor),
        ),
      ),
    );
  }
}
