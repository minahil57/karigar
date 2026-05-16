import 'package:karigar/export.dart';

class WorkHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkHistoryController>(() => WorkHistoryController());
  }
}
