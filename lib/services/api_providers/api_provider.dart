import 'package:karigar/export.dart';

part 'auth.dart';
part 'provider.dart';

abstract final class ApiProvider {
  static _Auth get auth => _Auth();
  static _Provider get provider => _Provider();
}
