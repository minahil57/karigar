import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  static Future<void> requestAppPermissions() async {
    final permissions = [
      Permission.notification,
      Permission.locationWhenInUse,
    ];

    for (var permission in permissions) {
      final status = await permission.status;
      if (!status.isGranted) {
        await permission.request();
      }
    }
  }
}
