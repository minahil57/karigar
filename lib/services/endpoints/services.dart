part of 'endpoints.dart';

class _Services {
  final String _apiBaseUrl;

  factory _Services({required String apiBaseUrl}) {
    _instance ??= _Services._sharedInstance(apiBaseUrl: apiBaseUrl);
    return _instance!;
  }

  _Services._sharedInstance({required String apiBaseUrl})
    : _apiBaseUrl = apiBaseUrl;
  static _Services? _instance;

  String get _controllerName => '$_apiBaseUrl/services';

  String get getAllServices => _controllerName;
  String get addProviderService => '$_apiBaseUrl/provider/services';
}
