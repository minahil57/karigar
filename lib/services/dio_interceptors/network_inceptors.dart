import 'package:karigar/export.dart';

final Interceptor networkInterceptor = InterceptorsWrapper(
  onError: (DioException e, ErrorInterceptorHandler handler) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.unknown) {
      showNetworkError();
    }

    return handler.next(e);
  },
);
