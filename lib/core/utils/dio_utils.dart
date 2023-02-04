import 'package:dio/dio.dart';
import 'package:test_3bee/core/constants.dart';
import 'package:test_3bee/core/instance_locator.dart';

class DioUtils {
  static Dio initApiClient() {
    final Dio dio = Dio();
    dio.interceptors.clear();
    dio.options.baseUrl = Constants.baseUrl;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final String token = localCache.getAccessToken()!;
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          if (e.response != null) {
            if (e.response?.statusCode == 401) {
              RequestOptions requestOptions = e.requestOptions;

              await authService.refreshUserToken(
                refreshToken: localCache.getRefreshToken()!,
              );

              final opts = Options(method: requestOptions.method);
              dio.options.headers['Authorization'] = 'Bearer ${localCache.getAccessToken()}';

              final response = await dio.request(
                requestOptions.path,
                options: opts,
                cancelToken: requestOptions.cancelToken,
                onReceiveProgress: requestOptions.onReceiveProgress,
                data: requestOptions.data,
                queryParameters: requestOptions.queryParameters,
              );

              handler.resolve(response);
            } else {
              handler.next(e);
            }
          }
        },
      ),
    );

    return dio;
  }
}
