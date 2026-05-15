part of 'api_provider.dart';

class _Auth {
  factory _Auth() {
    _instance ??= _Auth._sharedInstance();
    return _instance!;
  }

  _Auth._sharedInstance();

  static _Auth? _instance;

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return DioHelper.postData(
      endPoint: EndPoints.auth.login,
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  Future<void> logout({required Map<String, dynamic> data}) async {
    await DioHelper.postData(endPoint: EndPoints.auth.login, data: data);
  }

  Future<Response> forgetPassword({
    required Map<String, dynamic> data,
  }) async {
    return DioHelper.postData(
      endPoint: EndPoints.auth.login,
      data: data,
    );
  }

  Future<void> logoutFromAllDevices() async {
    await DioHelper.getData(endPoint: EndPoints.auth.login);
  }

  Future<Response> resetPassword({
    required Map<String, dynamic> data,
  }) async {
    return DioHelper.postData(
      endPoint: EndPoints.auth.login,
      data: data,
    );
  }

  Future<Response> changePassword({
    required Map<String, dynamic> data,
  }) async {
    return DioHelper.postData(
      endPoint: EndPoints.auth.login,
      data: data,
    );
  }

  Future<Response> refreshAccessToken({
    required String refreshToken,
  }) async {
    // this end  point must be called with a fresh dio instance which doesn't
    // have the AuthInterceptor
    final Dio dio = Dio();
    // dio.options.headers['apiKey'] = Constants.apiKey;
    return dio.post(
      EndPoints.auth.login,
      data: {
        'token': refreshToken,
      },
    );
  }
}
