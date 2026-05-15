import 'package:karigar/export.dart';

class AppNotifier extends ChangeNotifier {
  AppNotifier();

  Future<void> init() async {
    _changeTheme();
    notifyListeners();
  }

  void updateTheme(ThemeCustomizer themeCustomizer) {
    _changeTheme();

    notifyListeners();

    LocalStorage.setCustomizer(themeCustomizer);
  }

  Future<void> updateInStorage(ThemeCustomizer themeCustomizer) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('theme_customizer', themeCustomizer.toJSON());
  }

  void changeDirectionality(TextDirection textDirection, [bool notify = true]) {
    MainAppTheme.textDirection = textDirection;
    My.setTextDirection(textDirection);

    if (notify) notifyListeners();
  }

  // Future<void> changeLanguage(
  //   Language language, {
  //   bool notify = true,
  //   bool changeDirection = true,
  // }) async {
  //   if (changeDirection) {
  //     if (language.supportRTL) {
  //       changeDirectionality(TextDirection.rtl, false);
  //     } else {
  //       changeDirectionality(TextDirection.ltr, false);
  //     }
  //   }

  //   await ThemeCustomizer.changeLanguage(language);

  //   if (notify) notifyListeners();
  // }

  void _changeTheme() {
    MainAppTheme.theme = MainAppTheme.getThemeFromThemeMode();
    AppStyle.changeMyTheme();
  }
}
