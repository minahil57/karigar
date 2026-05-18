
import 'package:karigar/export.dart';

abstract final class LocalStorage {
  static const String email = 'email';
  static const String password = 'password';
  static const String rememberMeChecked = 'rememberMeChecked';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userDataKey = 'user_data';
  static const String _themeCustomizerKey = 'theme_customizer';
  static const String _languageKey = 'lang_code';
  static const String fcmToken = 'fcmToken';

  static SharedPreferences? _preferencesInstance;
  static const _secureStorage = FlutterSecureStorage();

  static SharedPreferences get _preferences {
    if (_preferencesInstance == null) {
      throw 'Call LocalStorage.init() to initialize local storage';
    }
    return _preferencesInstance!;
  }

  static Future<void> init() async {
    _preferencesInstance = await SharedPreferences.getInstance();
    await initData();
    log('local storage initialized');
  }

  static Future<void> initData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    AuthRepository.isLoggedIn = preferences.getBool(_isLoggedInKey) ?? false;
  //  ThemeCustomizer.fromJSON(preferences.getString(_themeCustomizerKey));
  }

  static Future<bool> saveData(String key, String data) async {
    return _preferences.setString(key, data);
  }

  static String? getData(String data) {
    return _preferences.getString(data);
  }

  static Future<bool> removeData(String data) async {
    return _preferences.remove(data);
  }

  static Future<bool> setLoggedInUser(bool loggedIn) async {
    return _preferences.setBool(_isLoggedInKey, loggedIn);
  }

  static Future<bool> setBool({
    required String key,
    required bool value,
  }) async {
    return _preferences.setBool(key, value);
  }

  static Future<bool> setCustomizer(ThemeCustomizer themeCustomizer) {
    return _preferences.setString(
      _themeCustomizerKey,
      themeCustomizer.toJSON(),
    );
  }

  static Future<bool> setLanguage(String langCode) {
    return _preferences.setString(_languageKey, langCode);
  }

  static String? getLanguage() {
    return _preferences.getString(_languageKey);
  }

  static Future<void> removeLoggedInUser() async {
    await _preferences.remove(_isLoggedInKey);
    await _preferences.remove(_userDataKey);
  }

  static bool? getBool({required String key}) {
    return _preferences.getBool(key);
  }

  // --- Secure Storage Methods ---

  static Future<void> saveSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecureData(String key) async {
    return await _secureStorage.read(key: key);
  }

  static Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  // --- User Model Methods ---

  static Future<void> setUser(UserModel user) async {
    await _preferences.setString(_userDataKey, jsonEncode(user.toJson()));
  }

  static UserModel? getUser() {
    String? userJson = _preferences.getString(_userDataKey);
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson));
  }

  static Future<void> setFcmToken(String token) async {
    await _preferences.setString(fcmToken, token);
  }

  static String? getFcmToken() {
    return _preferences.getString(fcmToken);
  }
}
