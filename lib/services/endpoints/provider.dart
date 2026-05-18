part of 'endpoints.dart';

class _Provider {
  final String _apiBaseUrl;

  factory _Provider({required String apiBaseUrl}) {
    _instance ??= _Provider._sharedInstance(apiBaseUrl: apiBaseUrl);
    return _instance!;
  }

  _Provider._sharedInstance({required String apiBaseUrl})
    : _apiBaseUrl = apiBaseUrl;
  static _Provider? _instance;

  String get _controllerName => '$_apiBaseUrl/provider';

  String get getAllProviders => '$_controllerName/';
  String get getProvider => '$_controllerName/get-provider';
  String get updateProvider => '$_controllerName/update-provider';
  String get profilePatch => '$_controllerName/profile';
  String get uploadAvatar => '$_apiBaseUrl/upload/avatar';
  String profile(String id) => '$_controllerName/profile/$id';
  String providerBookings(String id) => '$_controllerName/$id/bookings';
String updateBookingStatus(String id) => '$_controllerName/bookings/$id';
}
