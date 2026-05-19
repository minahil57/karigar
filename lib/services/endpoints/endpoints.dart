//ignore_for_file: library_private_types_in_public_api

part 'auth.dart';
part 'provider.dart';
part 'customer.dart';

abstract final class EndPoints {
  // static const String loginUrl = 'https://api.newcrm.freemyip.com'; // PROD
  static const String baseUrl = 'http://10.100.199.207:3000';
  static const String _apiBaseUrl = '$baseUrl/api';

  static _Auth get auth => _Auth(apiBaseUrl: _apiBaseUrl);
  static _Provider get provider => _Provider(apiBaseUrl: _apiBaseUrl);
  static _Customer get customer => _Customer(apiBaseUrl: _apiBaseUrl);
}
