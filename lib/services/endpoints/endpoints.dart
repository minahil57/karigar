//ignore_for_file: library_private_types_in_public_api

library endpoints;

part 'auth.dart';

abstract final class EndPoints {
  // static const String loginUrl = 'https://api.newcrm.freemyip.com'; // PROD
  static const String baseUrl = 'https://dev.api.newcrm.freemyip.com'; // DEV
  static const String _apiBaseUrl = '$baseUrl/api';
    


  static _Auth get auth => _Auth(apiBaseUrl: _apiBaseUrl);
}
