import 'package:karigar/export.dart';

class CustomerBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerBookingsController());
  }
}