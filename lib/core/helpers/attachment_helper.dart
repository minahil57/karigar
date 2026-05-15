import 'package:karigar/export.dart';

abstract final class AttachmentHelper {
  static Future<void> showFromMemoryImageDialog(Uint8List imageBytes) async {
    await Get.dialog(
      Dialog(child: Image.memory(imageBytes, fit: BoxFit.cover)),
    );
  }

  static Future<void> showFromNetworkImageDialog(String imageUrl) async {
    await Get.dialog(Dialog(child: Image.network(imageUrl, fit: BoxFit.cover)));
  }
}
