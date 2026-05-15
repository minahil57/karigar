import 'package:karigar/export.dart';

extension StringsExtension on String {
  /// Return '0' if the string is empty otherwise return the string itself.
  String get orZero => isEmpty ? '0' : this;

  String get cc => isEmpty || this == '0' ? 'None' : this;
}
