import 'package:karigar/export.dart';

final Interceptor authInterceptor = QueuedInterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({'Authorization': 'Bearer ${await getAccessToken()}'});
    return handler.next(options);
  },
  onError: (DioException e, ErrorInterceptorHandler handler) async {
    AppLogger.d('Begging onError interceptor...');
    final options = e.response?.requestOptions;
    if (e.response?.statusCode == 401) {
      AppLogger.d('Refreshing token...');

      String? newAccessToken = await AuthRepository.refreshAccessToken();
      if (newAccessToken != null) {
        // Update the request header with the new access token

        e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final opts = Options(
          method: e.requestOptions.method,
          headers: e.requestOptions.headers,
        );

        final originalRequest = await Dio().request(
          e.requestOptions.path,
          options: opts,
          data: e.requestOptions.data,
          queryParameters: e.requestOptions.queryParameters,
          cancelToken: e.requestOptions.cancelToken,
        );

        // Repeat the request with the updated header
        return handler.resolve(originalRequest);
      }

      AppLogger.f('Failed to refresh token');
      await AuthRepository.localLogout();
      Snackbars.expiredSession();
      return handler.reject(
        DioException(requestOptions: options!, message: 'Expired Session'),
      );
    }

    if (e.response?.statusCode == 403) {
      await AuthRepository.localLogout();
      Snackbars.expiredSession();
      return handler.reject(
        DioException(requestOptions: options!, message: 'Expired Session'),
      );
    }

    return handler.next(e);
  },
);
