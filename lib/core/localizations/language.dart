// import 'package:karigar/export.dart';

// class Language {
//   final Locale locale;
//   final bool supportRTL;
//   final String languageName;

//   static List<Language> languages = [
//     Language(const Locale('en'), 'English'),
//     Language(const Locale('ur'), 'اردو', true),
//   ];

//   Language(this.locale, this.languageName, [this.supportRTL = false]);
// }

//   static Future<bool> init() async {
//     ThemeCustomizer.instance.currentLanguage = await getLanguage();
//     return true;
//   }

//   static List<Locale> getLocales() {
//     return languages.map((e) => e.locale).toList();
//   }

//   static List<String> getLanguagesCodes() {
//     return languages.map((e) => e.locale.languageCode).toList();
//   }

//   static Future<Language> getLanguage() async {
//     Language? language;
//     String? langCode = LocalStorage.getLanguage();
//     if (langCode != null) {
//       language = findFromLocale(Locale(langCode));
//     }

//     return language ?? languages.first;
//   }

//   static Language getLanguageFromCode(String code) {
//     Language selectedLang = languages.first;
//     for (final language in languages) {
//       if (language.locale.languageCode == code) selectedLang = language;
//     }
//     return selectedLang;
//   }

//   static Language? findFromLocale(Locale locale) {
//     for (final Language language in languages) {
//       if (language.locale.languageCode == locale.languageCode) return language;
//     }
//     return null;
//   }

//   Language clone() {
//     return Language(locale, languageName, supportRTL);
//   }

//   @override
//   String toString() {
//     return 'Language{locale: $locale, isRTL: $supportRTL, languageName: $languageName}';
//   }
// }
