import 'package:karigar/export.dart';

class AuthRepository {
  static bool isLoggedIn = false;

  // static Future<void> _saveLoginData(LoginModel model) async {
  //   isLoggedIn = true;
  //   await LocalStorage.setLoggedInUser(true);
  //   await LocalStorage.setUserCompany(model.userCompanies![0]);
  //   await refreshLoginData(model);
  // }

  static Future<String?> loginUser(Map<String, dynamic> data) async {
    try {
      var response = await ApiProvider.auth.login(
        email: data['email'],
        password: data['password'],
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        return null;
      } else {
        return 'Something went wrong';
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return e.response?.data['data'];
      } else {
        return 'Something went wrong';
      }
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
    await LocalStorage.removeLoggedInUser();
    await LocalStorage.removeData(LocalStorage.accessToken);
    await LocalStorage.removeData(LocalStorage.refreshToken);
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
}
