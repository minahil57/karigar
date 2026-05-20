import 'package:karigar/export.dart';
import 'package:karigar/services/notifications/firebase_notification.dart';

class AuthRepository {
  static bool isLoggedIn = false;

  // static Future<void> _saveLoginData(LoginModel model) async {
  //   isLoggedIn = true;
  //   await LocalStorage.setLoggedInUser(true);
  //   await LocalStorage.setUserCompany(model.userCompanies![0]);
  //   await refreshLoginData(model);
  // }

  static Future<String?> registerUser(Map<String, dynamic> data) async {
    try {
      var response = await ApiProvider.auth.register(data: data);

      if (response.statusCode == 201) {
        return null;
      } else {
        return response.data['message'] ?? 'Something went wrong';
      }
    } on DioException catch (e) {
      return e.response?.data['message'] ?? 'Something went wrong';
    } on Exception {
      return 'Something went wrong';
    }
  }

  static Future<String?> loginUser(Map<String, dynamic> data) async {
    try {
      var response = await ApiProvider.auth.login(
        email: data['email'],
        password: data['password'],
      );

      if (response.statusCode == 200) {
        final loginData = response.data['data'];
        final token = loginData['token'];
        final userData = loginData['user'];

        await LocalStorage.saveSecureData(LocalStorage.accessToken, token);
        await LocalStorage.setUser(UserModel.fromJson(userData));
        await LocalStorage.setLoggedInUser(true);
        isLoggedIn = true;

        return null;
      } else {
        return response.data['message'] ?? 'Something went wrong';
      }
    } on DioException catch (e) {
      return e.response?.data['message'] ?? 'Something went wrong';
    } on Exception {
      return 'Something went wrong';
    }
  }

  static Future<Map<String, dynamic>> forgetPassword(
    Map<String, dynamic> data,
  ) async {
    try {
      var response = await ApiProvider.auth.forgetPassword(data: data);

      if (response.statusCode == 200 && response.data['status'] == true) {
        var userId = response.data['data']['userId'];
        return {'data': userId, 'error': null};
      } else {
        return {'data': null, 'error': 'Something went wrong'};
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return {'data': null, 'error': e.response?.data['data']};
      } else {
        return {'data': null, 'error': 'Something went wrong'};
      }
    } on Exception {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> resetPassword(
    Map<String, dynamic> data,
  ) async {
    try {
      var response = await ApiProvider.auth.resetPassword(data: data);

      if (response.statusCode == 200 && response.data['status'] == true) {
        return {'data': response.data['data'], 'error': null};
      } else {
        return {'data': null, 'error': 'Something went wrong'};
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return {'data': null, 'error': e.response?.data['data']};
      } else {
        return {'data': null, 'error': 'Something went wrong'};
      }
    } on Exception {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> changePassword(
    Map<String, dynamic> data,
  ) async {
    try {
      var response = await ApiProvider.auth.changePassword(data: data);

      if (response.statusCode == 200 && response.data['status'] == true) {
        return {'data': response.data['data'], 'error': null};
      } else {
        return {'data': null, 'error': 'Something went wrong'};
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return {'data': null, 'error': e.response?.data['data']};
      } else {
        return {'data': null, 'error': 'Something went wrong'};
      }
    } on Exception {
      return {'data': null, 'error': 'Something went wrong'};
    }
  }

  static Future<void> logoutAllDevices() async {
    await _serverLogoutAllDevices();
    await localLogout();
  }

  static Future<void> logout() async {
    await _serverLogout();
    await localLogout();
  }

  static Future<void> localLogout() async {
    await deleteFcmToken();
    await LocalStorage.removeLoggedInUser();
    await LocalStorage.removeData(
      LocalStorage.accessToken,
    ); // Clear non-secure if exists
    await LocalStorage.deleteSecureData(LocalStorage.accessToken);
    await LocalStorage.removeData(LocalStorage.refreshToken);
    await LocalStorage.deleteSecureData(LocalStorage.refreshToken);
    isLoggedIn = false;
    Get.offAllNamed(Routes.login);
  }

  static Future<void> _serverLogout() async {
    String? refreshToken = LocalStorage.getData(LocalStorage.refreshToken);
    var data = {'token': refreshToken ?? ''};
    await ApiProvider.auth.logout(data: data);
  }

  static Future<void> _serverLogoutAllDevices() async {
    await ApiProvider.auth.logoutFromAllDevices();
  }

  static Future<void> setRememberMe({
    required String email,
    required String password,
    required bool isChecked,
  }) async {
    await LocalStorage.saveData(LocalStorage.email, email);
    await LocalStorage.saveData(LocalStorage.password, password);
    await LocalStorage.setBool(
      key: LocalStorage.rememberMeChecked,
      value: isChecked,
    );
  }

  static (String? email, String? password, bool rememberMeChecked)
  getRememberMe() {
    String? email = LocalStorage.getData(LocalStorage.email);
    String? password = LocalStorage.getData(LocalStorage.password);
    bool? rememberMeChecked = LocalStorage.getBool(
      key: LocalStorage.rememberMeChecked,
    );

    return (email, password, rememberMeChecked ?? false);
  }

  static Future<void> removeRememberMe() async {
    await LocalStorage.removeData(LocalStorage.email);
    await LocalStorage.removeData(LocalStorage.password);
    await LocalStorage.removeData(LocalStorage.rememberMeChecked);
  }

  static Future<String?> refreshAccessToken() async {
    dynamic model;

    try {
      String? refreshToken = LocalStorage.getData(LocalStorage.refreshToken);
      var response = await ApiProvider.auth.refreshAccessToken(
        refreshToken: refreshToken ?? '',
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        //model = LoginModel.fromJson(response.data['data']);

        // await refreshLoginData(model);

        return model.accessToken!;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<void> refreshLoginData() async {
    // await LocalStorage.setLoginModel(model);
    // await LocalStorage.saveData(LocalStorage.accessToken, model.accessToken!);
    // await LocalStorage.saveData(LocalStorage.refreshToken, model.refreshToken!);
  }

  static Future<void> syncFcmToken() async {
    final fcmToken = await FirebaseNotificationService().getFcmToken();
    if (fcmToken == null || fcmToken.isEmpty) return;
    await LocalStorage.setFcmToken(fcmToken);
    await updateFcmToken();

    log("FCM Token: $fcmToken");
  }

  static Future<void> updateFcmToken() async {
    String? token = LocalStorage.getFcmToken();
    if (token != null && token.isNotEmpty) {
      await ApiProvider.auth.updateFcmToken(token: token);
    }
  }

  static Future<void> deleteFcmToken() async {
    final token = LocalStorage.getFcmToken();
    if (token != null && token.isNotEmpty) {
      try {
        await ApiProvider.auth.deleteFcmToken(token: token);
      } catch (e) {
        // Still clear local token if the server call fails.
        log('Error deleting FCM token: $e');
      }
    }
    await LocalStorage.removeData(LocalStorage.fcmToken);
  }
}
