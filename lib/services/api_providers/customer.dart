part of 'api_provider.dart';

class _Customer {
  factory _Customer() {
    _instance ??= _Customer._sharedInstance();
    return _instance!;
  }

  _Customer._sharedInstance();

  static _Customer? _instance;

  Future<Response> getBookings() async {
    return DioHelper.getData(endPoint: EndPoints.customer.bookings);
  }

  Future<Response> updateProfile({required Map<String, dynamic> data}) async {
    return DioHelper.patchData(endPoint: EndPoints.customer.updateProfile, data: data);
  }
}
