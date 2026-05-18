// ignore_for_file: library_private_types_in_public_api

import 'package:karigar/export.dart';

part 'auth.dart';
part 'provider.dart';
part 'customer.dart';

abstract final class ApiProvider {
  static _Auth get auth => _Auth();
  static _Provider get provider => _Provider();
  static _Customer get customer => _Customer();
}
