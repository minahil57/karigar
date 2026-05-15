import 'package:karigar/export.dart';

part 'auth.dart';

abstract final class ApiProvider {
  static _Auth get auth => _Auth();
}
