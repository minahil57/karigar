part of 'api_provider.dart';

class _Services {
  factory _Services() {
    _instance ??= _Services._sharedInstance();
    return _instance!;
  }

  _Services._sharedInstance();

  static _Services? _instance;

  Future<Response> getAllServices() async {
    return DioHelper.getData(
      endPoint: EndPoints.services.getAllServices,
    );
  }

  Future<Response> addProviderService(Map<String, dynamic> data) async {
    return DioHelper.postData(
      endPoint: EndPoints.services.addProviderService,
      data: data,
    );
  }
}
