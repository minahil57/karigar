import 'package:karigar/export.dart';
import '../main/work_history_controller.dart';

class WorkHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkHistoryController>(() => WorkHistoryController());
  }
}
