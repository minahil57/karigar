part of 'endpoints.dart';

class _Auth {
  final String _apiBaseUrl;

  factory _Auth({required String apiBaseUrl}) {
    _instance ??= _Auth._sharedInstance(apiBaseUrl: apiBaseUrl);
    return _instance!;
  }

  _Auth._sharedInstance({required String apiBaseUrl})
    : _apiBaseUrl = apiBaseUrl;
  static _Auth? _instance;

  String get _controllerName => '$_apiBaseUrl/auth';

  String get register => '$_controllerName/sign-up';
  String get login => '$_controllerName/sign-in';
  String get refreshToken => '$_controllerName/refresh-token';
  String get fcmToken => '$_controllerName/fcm-token';
}
