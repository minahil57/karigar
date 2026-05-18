import 'package:karigar/export.dart';

class Language {
  final Locale locale;
  final String languageName;
  final bool supportRTL;

  static List<Language> languages = [
    Language(const Locale('en', 'US'), 'English'),
    Language(const Locale('ur', 'PK'), 'اردو', true),
  ];

  Language(this.locale, this.languageName, [this.supportRTL = false]);
}

class LocalizationService {
  static const fallbackLocale = Locale('en', 'US');

  static Locale get currentLocale {
    final langCode = LocalStorage.getLanguage();
    if (langCode != null) {
      if (langCode == 'ur') {
        return const Locale('ur', 'PK');
      }
    }
    return const Locale('en', 'US');
  }

  static bool get isUrdu => currentLocale.languageCode == 'ur';

  static void changeLocale(String langCode) {
    final locale = langCode == 'ur' ? const Locale('ur', 'PK') : const Locale('en', 'US');
    Get.updateLocale(locale);
    LocalStorage.setLanguage(langCode);
  }
}
