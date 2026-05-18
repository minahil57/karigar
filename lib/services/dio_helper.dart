import 'package:karigar/export.dart';

abstract final class DioHelper {
  static late Dio _dio;
  static late Dio _dioWithoutAuth;

  static void init() {
    _dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
        headers: {
          'Content-Type': 'application/json',
          'apiKey': '',
          'lang': 'en-US',
          'Authorization': 'Bearer ${getAccessToken()}',
        },
      ),
    )..interceptors.addAll(dioInterceptoprs);
    _dioWithoutAuth = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
      ),
    )..interceptors.addAll([loggerInterceptor, networkInterceptor]);
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(endPoint, queryParameters: queryParameters);
  }

  static Future<Response> getDataWithOutInterceptors({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dioWithoutAuth.get(endPoint, queryParameters: queryParameters);
  }

  static Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
  }) async {
    return _dio.post(endPoint, queryParameters: queryParameters, data: data);
  }

  static Future<Response> postMediaUpload({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
  }) async {
    return _dio.post(endPoint, queryParameters: queryParameters, data: data);
  }

  static Future<Response> posttDataWithOutInterceptors({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
  }) async {
    return _dioWithoutAuth.post(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );
  }

  static Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
  }) async {
    return _dio.put(endPoint, queryParameters: queryParameters, data: data);
  }

  static Future<Response> patchData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
  }) async {
    return _dio.patch(endPoint, queryParameters: queryParameters, data: data);
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

  static Future<Response> uploadSingleFile({
    required XFile file,
    required String endPoint,
  }) async {
    final bytes = await file.readAsBytes();

    final formData = FormData.fromMap({
      "avatar": MultipartFile.fromBytes(
        bytes,
        filename: file.name,
        contentType: MediaType.parse(
          lookupMimeType(file.name) ?? 'application/octet-stream',
        ),
      ),
      "file_type": file.name.split('.').last,
      "original_filename": file.name,
      "file_size": bytes.length,
    });

    return await postMediaUpload(endPoint: endPoint, data: formData);
  }
}
