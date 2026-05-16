part of 'api_provider.dart';

class _Provider {
  factory _Provider() {
    _instance ??= _Provider._sharedInstance();
    return _instance!;
  }

  _Provider._sharedInstance();

  static _Provider? _instance;

  
  Future<Response> getAllProviders({
    required Map<String, dynamic> queryParameters,
  }) async {
    return DioHelper.getData(
      endPoint: EndPoints.provider.getAllProviders,
      queryParameters: queryParameters,
    );
  }

  Future<Response> getProvider({
    required Map<String, dynamic> data,
  }) async {
    return DioHelper.posttDataWithOutInterceptors(
      endPoint: EndPoints.provider.getProvider,
      data: data,
    );
  }
}
