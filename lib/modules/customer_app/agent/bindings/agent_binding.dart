import 'package:karigar/export.dart';

class AgentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SocketService(), permanent: true);
    Get.lazyPut(() => AgentController());
  }
}