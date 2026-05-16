//ignore_for_file: library_private_types_in_public_api



part 'auth.dart';

abstract final class EndPoints {
  // static const String loginUrl = 'https://api.newcrm.freemyip.com'; // PROD
  static const String baseUrl = 'http://192.168.1.32:3000';
  static const String _apiBaseUrl = '$baseUrl/api';

  static _Auth get auth => _Auth(apiBaseUrl: _apiBaseUrl);
}
