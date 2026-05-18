import 'package:karigar/export.dart';

class CustomerBookingsController extends GetxController {
  List<ServiceRequestModel> _bookings = [];

  List<ServiceRequestModel> get bookings => _bookings;

  set bookings(List<ServiceRequestModel> value) {
    _bookings = value;
    update(['bookings']);
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update(['bookings']);
  }

  @override 
  void onInit() {
    super.onInit();
    getBookings();
  }

  Future<void> getBookings() async {
    try {
      isLoading = true;
      bookings = dummyServiceRequests;
      final result = await CustomerRepository.getBookings();
      if (result['error'] == null) {
        bookings = result['data'];
      } else {
        bookings = [];
        log(result['error'].toString());
      }
    } catch (e) {
      bookings = [];
      log('Error in getBookings: $e');
    } finally {
      isLoading = false;
    }
  }
}
