import 'package:karigar/export.dart';

abstract final class DioHelper {
  static late Dio _dio;

  static void init() {
    _dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
        headers: {
          //TODO: Update headers as per your API requirements
          'Content-Type': 'application/json',
          'apiKey': '',
          'lang': 'en-US',
        },
      ),
    )..interceptors.addAll(dioInterceptoprs);
    log('DioHelper initialized');
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(endPoint, queryParameters: queryParameters);
  }

  static Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
  }) async {
    return _dio.post(endPoint, queryParameters: queryParameters, data: data);
  }

  static Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
  }) async {
    return _dio.put(endPoint, queryParameters: queryParameters, data: data);
  }

  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    return _dio.delete(endPoint, queryParameters: queryParameters, data: data);
  }

  static Future<List<String>> uploadFiles({
    required List<XFile> files,
    required String endPoint,
  }) async {
    List<Map<String, Uint8List>> filesAsBytes = await Future.wait(
      files.map((file) async {
        return {file.name: await file.readAsBytes()};
      }).toList(),
    );

    final formData = FormData.fromMap({
      'files': filesAsBytes
          .map(
            (file) => MultipartFile.fromBytes(
              file.values.first,
              filename: file.keys.first,
              contentType: MediaType.parse(
                lookupMimeType(file.keys.first) ?? 'application/octet-stream',
              ),
            ),
          )
          .toList(),
    });

    var response = await postData(endPoint: endPoint, data: formData);
    if (response.statusCode == 200) {
      return response.data['data'].cast<String>();
    } else {
      return [];
    }
  }
}
