part of 'endpoints.dart';

class _Customer {
  final String _apiBaseUrl;

  factory _Customer({required String apiBaseUrl}) {
    _instance ??= _Customer._sharedInstance(apiBaseUrl: apiBaseUrl);
    return _instance!;
  }

  _Customer._sharedInstance({required String apiBaseUrl})
    : _apiBaseUrl = apiBaseUrl;
  static _Customer? _instance;

  String get _controllerName => '$_apiBaseUrl/user';

  String get bookings => '$_controllerName/bookings';
  String get updateProfile => '$_controllerName/profile';
}
