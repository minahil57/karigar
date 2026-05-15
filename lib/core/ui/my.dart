import 'package:karigar/export.dart';

class My {
  // entry point of the package
  void init() {}

  static void changeTheme(ThemeData theme) {
    AppTheme.theme = theme;
  }

  static void setTextDirection(TextDirection direction) {
    AppTheme.textDirection = direction;
  }

  static void setConstant(MyConstantData constantData) {
    MyConstant.constant = constantData;
  }

}
